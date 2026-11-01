#include <QAccessible>
#include <QAbstractListModel>
#include <QCommandLineParser>
#include <QCryptographicHash>
#include <QDebug>
#include <QDir>
#include <QFile>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QQuickWindow>
#include <QQuickItem>
#include <QTimer>
#include <QImage>
#include <QTest>
#include <QPointF>
#include <QSortFilterProxyModel>
#include <QTemporaryDir>
#include <QVariant>
#include <cmath>
#include "rentalsystem.h"
#include "src/application/fleet_read_service.h"
#include "src/application/rental_read_service.h"
#include "src/application/rental_list_model.h"
#include "src/application/rental_quote_service.h"
#include "src/application/rental_confirm_service.h"
#include "src/application/rental_return_controller.h"
#include "src/application/rental_booking_controller.h"
#include "src/application/rental_archive_controller.h"
#include "motion_policy.h"

// The P3 typed application read boundary snapshots RentalSystem objects as
// values from disposable fictional fixtures. No Vehicle* reaches QML.
class FleetModel final : public QAbstractListModel {
    Q_OBJECT
public:
    enum Role {
        VehicleId = Qt::UserRole + 1,
        DisplayName, VehicleType, DailyRate, Available, Details
    };
    explicit FleetModel(const FleetReadService &readService, QObject *parent = nullptr)
        : QAbstractListModel(parent), m_readService(readService),
          m_vehicles(readService.vehicles()) {}
    // Explicitly re-snapshot the authoritative domain only when the caller
    // knows its transaction has committed. No implicit polling or UI writes.
    void refresh() {
        beginResetModel();
        m_vehicles = m_readService.vehicles();
        endResetModel();
    }
    const FleetVehicleSummary *findById(const QString &id) const {
        for (const auto &item : m_vehicles) {
            if (item.id.compare(id.trimmed(), Qt::CaseInsensitive) == 0)
                return &item;
        }
        return nullptr;
    }
    int availableCount() const {
        int count = 0;
        for (const auto &v : m_vehicles) count += v.available;
        return count;
    }
    int rowCount(const QModelIndex &parent = QModelIndex()) const override {
        return parent.isValid() ? 0 : m_vehicles.size();
    }
    QVariant data(const QModelIndex &index, int role) const override {
        if (!index.isValid() || index.row() < 0 || index.row() >= m_vehicles.size())
            return {};
        const FleetVehicleSummary &v = m_vehicles.at(index.row());
        switch (role) {
        case VehicleId: return v.id;
        case DisplayName: return v.displayName();
        case VehicleType: return v.type;
        case DailyRate: return v.legacyDailyRate;
        case Available: return v.available;
        case Details: return v.details;
        default: return {};
        }
    }
    QHash<int, QByteArray> roleNames() const override {
        return {{VehicleId,"vehicleId"},{DisplayName,"displayName"},
                {VehicleType,"vehicleType"},{DailyRate,"dailyRate"},
                {Available,"available"},{Details,"details"}};
    }
private:
    const FleetReadService &m_readService;
    QList<FleetVehicleSummary> m_vehicles;
};

class FleetProxy final : public QSortFilterProxyModel {
    Q_OBJECT
public:
    explicit FleetProxy(QObject *parent = nullptr) : QSortFilterProxyModel(parent) {
        setDynamicSortFilter(true);
        sort(0);
    }
    void setQuery(const QString &query) {
        if (m_query == query) return;
        m_query = query;
        invalidateFilter();
    }
    void setStatus(const QString &status) {
        if (m_status == status) return;
        m_status = status;
        invalidateFilter();
    }
    void setSortBy(const QString &sortBy) {
        if (m_sortBy == sortBy) return;
        m_sortBy = sortBy;
        invalidate();
        sort(0);
    }
protected:
    bool filterAcceptsRow(int row, const QModelIndex &parent) const override {
        const auto idx = sourceModel()->index(row, 0, parent);
        const QString id = idx.data(FleetModel::VehicleId).toString();
        const QString name = idx.data(FleetModel::DisplayName).toString();
        const bool available = idx.data(FleetModel::Available).toBool();
        const bool queryMatch = id.contains(m_query, Qt::CaseInsensitive) ||
                                name.contains(m_query, Qt::CaseInsensitive);
        const bool statusMatch = m_status == "All" ||
                                 (m_status == "Available" && available) ||
                                 (m_status == "Rented" && !available);
        return queryMatch && statusMatch;
    }
    bool lessThan(const QModelIndex &lhs, const QModelIndex &rhs) const override {
        if (m_sortBy == "Rate") {
            const double a = lhs.data(FleetModel::DailyRate).toDouble();
            const double b = rhs.data(FleetModel::DailyRate).toDouble();
            if (a != b) return a < b;
        }
        return QString::localeAwareCompare(
                   lhs.data(FleetModel::DisplayName).toString(),
                   rhs.data(FleetModel::DisplayName).toString()) < 0;
    }
private:
    QString m_query;
    QString m_status = "All";
    QString m_sortBy = "Name";
};

class FleetController final : public QObject {
    Q_OBJECT
    Q_PROPERTY(QObject* visibleModel READ visibleModel CONSTANT)
    Q_PROPERTY(QString query READ query WRITE setQuery NOTIFY queryChanged)
    Q_PROPERTY(QString status READ status WRITE setStatus NOTIFY statusChanged)
    Q_PROPERTY(QString sortBy READ sortBy WRITE setSortBy NOTIFY sortByChanged)
    Q_PROPERTY(QString selectedId READ selectedId NOTIFY selectionChanged)
    Q_PROPERTY(QString selectedName READ selectedName NOTIFY selectionChanged)
    Q_PROPERTY(QString selectedType READ selectedType NOTIFY selectionChanged)
    Q_PROPERTY(QString selectedDetails READ selectedDetails NOTIFY selectionChanged)
    Q_PROPERTY(QString selectedRate READ selectedRate NOTIFY selectionChanged)
    Q_PROPERTY(bool selectedAvailable READ selectedAvailable NOTIFY selectionChanged)
    Q_PROPERTY(int totalCount READ totalCount NOTIFY fleetChanged)
    Q_PROPERTY(int availableCount READ availableCount NOTIFY fleetChanged)
public:
    explicit FleetController(RentalSystem &system, QObject *parent = nullptr)
        : QObject(parent), m_readService(system), m_source(m_readService, this), m_proxy(this) {
        m_proxy.setSourceModel(&m_source);
        m_proxy.sort(0);
    }
    QObject *visibleModel() { return &m_proxy; }
    QString query() const { return m_query; }
    QString status() const { return m_status; }
    QString sortBy() const { return m_sort; }
    void setQuery(const QString &query) {
        if (query == m_query) return;
        m_query = query;
        m_proxy.setQuery(query);
        clearHiddenSelection();
        emit queryChanged();
    }
    void setStatus(const QString &status) {
        if (status != "All" && status != "Available" && status != "Rented") return;
        if (status == m_status) return;
        m_status = status;
        m_proxy.setStatus(status);
        clearHiddenSelection();
        emit statusChanged();
    }
    void setSortBy(const QString &sort) {
        if (sort != "Name" && sort != "Rate") return;
        if (sort == m_sort) return;
        m_sort = sort;
        m_proxy.setSortBy(sort);
        emit sortByChanged();
    }
    QString selectedId() const { return m_selectedId; }
    QString selectedName() const {
        const auto *v = selectedVehicle();
        return v ? v->displayName() : QString();
    }
    QString selectedType() const {
        const auto *v = selectedVehicle();
        return v ? v->type : QString();
    }
    QString selectedDetails() const {
        const auto *v = selectedVehicle();
        return v ? v->details : QString();
    }
    QString selectedRate() const {
        const auto *v = selectedVehicle();
        return v ? QString::number(v->legacyDailyRate, 'f', 2) : QString();
    }
    bool selectedAvailable() const {
        const auto *v = selectedVehicle();
        return v && v->available;
    }
    int totalCount() const { return m_source.rowCount(); }
    int availableCount() const { return m_source.availableCount(); }

    // An application command, NOT a QML Button, should call this after a
    // successful domain commit. Refresh both Fleet and Rentals in the same
    // non-reentrant caller turn so Overview/Fleet cannot stay stale.
    void refreshAfterCommit() {
        const QString previouslySelected = m_selectedId;
        m_source.refresh();
        if (!m_selectedId.isEmpty() && selectedVisibleIndex() < 0)
            m_selectedId.clear();
        emit fleetChanged();
        // Existing QML selected-rate/status roles depend on this signal even
        // when the same selected ID now has different domain properties.
        if (!previouslySelected.isEmpty())
            emit selectionChanged();
    }

    Q_INVOKABLE void selectById(const QString &id) {
        const auto *vehicle = m_source.findById(id);
        if (!vehicle) return;
        if (m_selectedId == vehicle->id) return;
        m_selectedId = vehicle->id;
        emit selectionChanged();
    }
    // Visible rows are defined by the authoritative C++ proxy, not QML's
    // scroll offsets. Keyboard navigation therefore follows filtered/sorted IDs.
    Q_INVOKABLE int selectedVisibleIndex() const {
        if (m_selectedId.isEmpty()) return -1;
        for (int row = 0; row < m_proxy.rowCount(); ++row) {
            if (m_proxy.index(row, 0).data(FleetModel::VehicleId).toString()
                == m_selectedId) return row;
        }
        return -1;
    }
    Q_INVOKABLE void selectVisibleIndex(int row) {
        if (row < 0 || row >= m_proxy.rowCount()) return;
        selectById(m_proxy.index(row, 0).data(FleetModel::VehicleId).toString());
    }
    Q_INVOKABLE void clearSelection() {
        if (m_selectedId.isEmpty()) return;
        m_selectedId.clear();
        emit selectionChanged();
    }
signals:
    void queryChanged();
    void statusChanged();
    void sortByChanged();
    void selectionChanged();
    void fleetChanged();
private:
    // Clearing a now-invisible ID prevents the Inspector from describing a
    // vehicle that no longer exists in the user's filtered Fleet view.
    void clearHiddenSelection() {
        if (!m_selectedId.isEmpty() && selectedVisibleIndex() < 0)
            clearSelection();
    }
    const FleetVehicleSummary *selectedVehicle() const {
        return m_selectedId.isEmpty()
            ? nullptr : m_source.findById(m_selectedId);
    }
    FleetReadService m_readService;
    FleetModel m_source;
    FleetProxy m_proxy;
    QString m_query;
    QString m_status = "All";
    QString m_sort = "Name";
    QString m_selectedId;
};

static bool readFile(const QString &path, QByteArray *bytes) {
    QFile f(path);
    if (!f.open(QIODevice::ReadOnly)) return false;
    *bytes = f.readAll();
    return f.error() == QFile::NoError;
}

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    QCoreApplication::setApplicationName("RentalStudioP2Spike");
    QCommandLineParser parser;
    parser.addHelpOption();
    parser.addOption({"self-test", "Test model, filtering, selection, and fixture integrity without a GUI."});
    parser.addOption({"ui-smoke", "Load the native QML scene and capture actual Gallery/Table views."});
    parser.addOption({"compact", "Use the compact 1280x720 viewport for the UI smoke."});
    parser.addOption({"input-smoke", "Drive actual QML buttons with keyboard events and test live resize."});
    parser.addOption({"arrows-smoke", "Exercise native QML Gallery/Table arrow navigation, focus, and filter parity."});
    parser.addOption({"focus-edges-smoke", "Test filtered selection, sorted focus, empty states, boundaries and responsive columns."});
    parser.addOption({"dpi-smoke", "Assert a real Qt window screenshot with synthetic device pixel ratio."});
    parser.addOption({"rentals-smoke", "Test the real read-only QML Rentals view and C++ commit-triggered refresh."});
    parser.addOption({"rentals-filter-smoke", "Test real QML Active/History filtering and keyboard selected IDs."});
    parser.addOption({"rentals-return-smoke", "Test real QML confirmed return through C++ domain and model refresh."});
    parser.addOption({"rentals-booking-smoke", "Drive real QML booking review and domain confirm in temporary fixtures."});
    parser.addOption({"rentals-archive-smoke", "Drive real QML archival confirmation on a returned fictional rental."});
    parser.addOption({"p4-shell-smoke", "Verify shared Qt Quick focus and keyboard/modal shell at wide/compact sizes."});
    parser.addOption({"p4-components-smoke", "Drive reusable rental fields, status and safe shared confirmation dialogs."});
    parser.addOption({"p4-tab-smoke", "Test Qt-native Fleet tab order and bounded modal Tab/Shift+Tab across workspaces."});
    parser.addOption({"p4-a11y-smoke", "Check live Qt accessibility names, roles and mutually exclusive states on fictional controls."});
    parser.addOption({"p4-motion-smoke", "Test native Qt Quick reduced-motion policy with fictional data only."});
    parser.addOption({"p4-reduce-motion", "Test-only reduced-motion preference; requires --p4-motion-smoke."});
    parser.process(app);

    // No source-adjacent storage or external/customer-data CLI argument.
    // For a portable review kit prefer only bundled fake fixtures.
    // Otherwise fall back to source-tree fake fixtures for Qt Creator/CI.
    // No arbitrary --data-dir or real customer path can be supplied.
    const QDir bundled(QDir(QCoreApplication::applicationDirPath()).filePath("demo"));
    const QDir source(bundled.exists()
                      ? bundled.absolutePath()
                      : QStringLiteral(RENTAL_STUDIO_DEMO_DIR));
    QTemporaryDir disposable;
    if (!disposable.isValid()) {
        qCritical() << "Cannot create isolated fixture directory";
        return 2;
    }
    QByteArray beforeVehicles, beforeRentals;
    const QString vehicles = source.filePath("vehicles.txt");
    const QString rentals = source.filePath("rentals.txt");
    if (!readFile(vehicles, &beforeVehicles) ||
        !readFile(rentals, &beforeRentals)) {
        qCritical() << "Cannot read only fictional demo fixtures";
        return 3;
    }
    // Reject swapped fixtures. Build-time hashes are taken from the exact
    // committed demo files; no customer data is ever accidentally imported.
    const QByteArray vehicleHash =
        QCryptographicHash::hash(beforeVehicles, QCryptographicHash::Sha256).toHex();
    const QByteArray rentalHash =
        QCryptographicHash::hash(beforeRentals, QCryptographicHash::Sha256).toHex();
    if (vehicleHash != QByteArray(RENTAL_STUDIO_DEMO_VEHICLES_SHA256) ||
        rentalHash != QByteArray(RENTAL_STUDIO_DEMO_RENTALS_SHA256)) {
        qCritical() << "P2 fixture mismatch: refusing non-demo files";
        return 3;
    }
    if (!QFile::copy(vehicles, disposable.filePath("vehicles.txt")) ||
        !QFile::copy(rentals, disposable.filePath("rentals.txt"))) {
        qCritical() << "Cannot create disposable demo fixture copies";
        return 3;
    }

    RentalSystem system(disposable.path());
    FleetController fleet(system);
    RentalReadService rentalRead(system);
    RentalListModel rentalModel(rentalRead);
    RentalReturnController rentalActions(system, rentalRead, rentalModel,
                                         [&fleet]{ fleet.refreshAfterCommit(); });
    RentalBookingController bookingActions(system, rentalModel,
                                            [&fleet]{ fleet.refreshAfterCommit(); });
    RentalArchiveController archiveActions(system, rentalRead, rentalModel);
    if (parser.isSet("self-test")) {
    const Vehicle *corolla = system.findVehicleById("C001");
    if (!corolla) {
        qCritical() << "Expected fictional Corolla C001 missing";
        return 4;
    }
        bool ok = fleet.totalCount() == 5 && fleet.availableCount() == 4
               && qFuzzyCompare(1.0 + corolla->getPricePerDay(), 451.0);
        fleet.setQuery("Honda");
        ok = ok && static_cast<FleetProxy*>(fleet.visibleModel())->rowCount() == 1;
        fleet.selectById("M001");
        ok = ok && fleet.selectedId() == "M001";
        fleet.setQuery("");
        fleet.setStatus("Rented");
        // A hidden vehicle must no longer remain in the visible Inspector.
        ok = ok && static_cast<FleetProxy*>(fleet.visibleModel())->rowCount() == 1
                && fleet.selectedId().isEmpty();
        fleet.setSortBy("Rate");
        fleet.setStatus("All");
        fleet.selectById("M001");
        ok = ok && static_cast<FleetProxy*>(fleet.visibleModel())->rowCount() == 5
                && fleet.selectedId() == "M001"
                && fleet.selectedVisibleIndex() >= 0;
        fleet.selectById("C002");
        ok = ok && !fleet.selectedAvailable();
        fleet.clearSelection();
        ok = ok && fleet.selectedId().isEmpty();
        QByteArray afterVehicles, afterRentals;
        ok = ok && readFile(vehicles, &afterVehicles) && readFile(rentals, &afterRentals)
                && beforeVehicles == afterVehicles && beforeRentals == afterRentals;
        if (!ok) {
            qCritical() << "P2 C++ model self-test FAILED";
            return 4;
        }
        qInfo() << "P2 C++ model self-test PASS: 5 fleet, search/status/sort/selection, read-only demo";
        return 0;
    }
    // Only the dedicated synthetic smoke can override the OS preference.
    MotionPolicy motion;
    if (parser.isSet("p4-motion-smoke"))
        motion.setTestPreference(parser.isSet("p4-reduce-motion"));
    app.installNativeEventFilter(&motion);
    QObject::connect(&app, &QGuiApplication::applicationStateChanged,
                     &motion, [&motion](Qt::ApplicationState) {
                         motion.refreshFromSystem();
                     });
    QQuickStyle::setStyle("Basic");
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("motionPolicy", &motion);
    engine.rootContext()->setContextProperty("fleet", &fleet);
    engine.rootContext()->setContextProperty("rentalsModel", &rentalModel);
    engine.rootContext()->setContextProperty("rentalActions", &rentalActions);
    engine.rootContext()->setContextProperty("bookingActions", &bookingActions);
    engine.rootContext()->setContextProperty("archiveActions", &archiveActions);
    engine.loadFromModule("RentalStudioSpike", "Main");
    if (engine.rootObjects().isEmpty()) {
        qCritical() << "Qt Quick did not load the P2 window";
        return 5;
    }
    if (parser.isSet("ui-smoke")) {
        auto *window = qobject_cast<QQuickWindow*>(engine.rootObjects().first());
        if (!window) {
            qCritical() << "P2 QML root is not a native Quick window";
            return 6;
        }
        auto *gallery = window->findChild<QQuickItem*>("fleetGallery");
        auto *table = window->findChild<QQuickItem*>("fleetTable");
        if (!gallery || !table || fleet.totalCount() != 5 ||
            fleet.availableCount() != 4) {
            qCritical() << "P2 native QML view objects or demo domain data missing";
            return 7;
        }

        const bool compact = parser.isSet("compact");
        window->setWidth(compact ? 1280 : 1500);
        window->setHeight(compact ? 720 : 860);
        const QString suffix = compact ? "1280x720" : "1500x860";
        // A real QQuickWindow screenshot is deliberately required for this
        // optional CI smoke. Failure cannot masquerade as passing native UI.
        QTimer::singleShot(1000, &app, [&, suffix] {
            if (!gallery->isVisible() || table->isVisible()) {
                qCritical() << "Gallery is not the visible initial Fleet view";
                app.exit(8); return;
            }
            QImage image = window->grabWindow();
            const QSize expected(compact ? 1280 : 1500, compact ? 720 : 860);
            if (image.size() != expected) {
                qCritical() << "Native screenshot viewport mismatch; expected"
                            << expected << "actual" << image.size();
                app.exit(12); return;
            }
            if (image.isNull() ||
                !image.save("p2-qt-gallery-" + suffix + ".png", "PNG")) {
                qCritical() << "Cannot capture actual QML Gallery";
                app.exit(9); return;
            }
            fleet.setQuery("Honda");
            fleet.selectById("M001");
            window->setProperty("gallery", false);
            QTimer::singleShot(450, &app, [&, suffix] {
                if (gallery->isVisible() || !table->isVisible() ||
                    fleet.selectedId() != "M001" ||
                    static_cast<FleetProxy*>(fleet.visibleModel())->rowCount() != 1) {
                    qCritical() << "QML Gallery/Table visibility or C++ model parity failed";
                    app.exit(10); return;
                }
                QImage tableImage = window->grabWindow();
                if (tableImage.size() != QSize(compact ? 1280 : 1500,
                                              compact ? 720 : 860)) {
                    qCritical() << "Native Table screenshot viewport mismatch; actual"
                                << tableImage.size();
                    app.exit(13); return;
                }
                if (tableImage.isNull() ||
                    !tableImage.save("p2-qt-table-" + suffix + ".png", "PNG")) {
                    qCritical() << "Cannot capture actual QML Table";
                    app.exit(11); return;
                }
                qInfo() << "P2 native Qt Quick UI smoke PASS:" << suffix
                        << "Gallery, Table, selected ID, filtered domain model";
                app.exit(0);
            });
        });
    }
    if (parser.isSet("input-smoke")) {
        auto *window = qobject_cast<QQuickWindow*>(engine.rootObjects().first());
        if (!window) return 20;
        QTimer::singleShot(850, &app, [&, window] {
            auto *tableToggle = window->findChild<QQuickItem*>("fleetTableToggle");
            auto *galleryToggle = window->findChild<QQuickItem*>("fleetGalleryToggle");
            auto *inspector = window->findChild<QQuickItem*>("vehicleInspector");
            if (!tableToggle || !galleryToggle || !inspector) {
                qCritical() << "Missing native keyboard test controls"; app.exit(21); return;
            }
            tableToggle->forceActiveFocus(Qt::TabFocusReason);
            QTest::keyClick(window, Qt::Key_Space);
            QCoreApplication::processEvents();
            if (window->property("gallery").toBool()) {
                qCritical() << "Space did not activate Table button"; app.exit(22); return;
            }
            // ListView delegates are dynamically instantiated and can be
            // visually parented without being QObject children of QQuickWindow.
            // Wait for the actual native frame and traverse *visual* items.
            QTest::qWait(180);
            const auto findVisual = [](const auto &self, QQuickItem *item,
                                       const QString &name) -> QQuickItem* {
                if (!item) return nullptr;
                if (item->objectName() == name && item->isVisible()) return item;
                for (QQuickItem *child : item->childItems()) {
                    if (auto *match = self(self, child, name)) return match;
                }
                return nullptr;
            };
            auto *tableView = findVisual(findVisual, window->contentItem(),
                                         QStringLiteral("fleetTable"));
            auto *row = findVisual(findVisual, tableView,
                                   QStringLiteral("fleetTableRow"));
            if (!tableView || !tableView->isVisible() ||
                !row || !row->property("vehicleId").isValid()) {
                qCritical() << "Visible Qt Table delegate not found after layout"
                            << "table" << tableView
                            << "row" << row;
                app.exit(23); return;
            }
            const QString expectedId = row->property("vehicleId").toString();
            row->forceActiveFocus(Qt::TabFocusReason);
            QTest::keyClick(window, Qt::Key_Space);
            QCoreApplication::processEvents();
            if (fleet.selectedId() != expectedId) {
                qCritical() << "Space did not select C++ row" << fleet.selectedId()
                            << expectedId;
                app.exit(24); return;
            }
            QTest::keyClick(window, Qt::Key_Escape);
            QCoreApplication::processEvents();
            if (!fleet.selectedId().isEmpty()) {
                qCritical() << "Escape did not clear Inspector"; app.exit(25); return;
            }
            galleryToggle->forceActiveFocus(Qt::TabFocusReason);
            QTest::keyClick(window, Qt::Key_Space);
            QCoreApplication::processEvents();
            if (!window->property("gallery").toBool()) {
                qCritical() << "Space did not restore Gallery"; app.exit(26); return;
            }

            // Resize the *same* running Qt Quick window rather than creating
            // separate fixed-size screenshots. No restart or mock view swap.
            window->resize(1280, 720);
            QTimer::singleShot(300, &app, [&, window, inspector] {
                const QPointF topLeft = inspector->mapToScene(QPointF(0, 0));
                const QPointF bottomRight = inspector->mapToScene(
                    QPointF(inspector->width(), inspector->height()));
                if (window->width() != 1280 || window->height() != 720 ||
                    topLeft.x() < -1 || topLeft.y() < -1 ||
                    bottomRight.x() > window->width() + 1 ||
                    bottomRight.y() > window->height() + 1) {
                    qCritical() << "Live compact resize clipped Inspector"
                                << topLeft << bottomRight
                                << window->width() << window->height();
                    app.exit(27); return;
                }
                window->resize(1500, 860);
                QTimer::singleShot(200, &app, [&, window] {
                    if (window->size() != QSize(1500, 860)) {
                        qCritical() << "Live wide resize failed" << window->size();
                        app.exit(28); return;
                    }
                    qInfo() << "P2 REAL keyboard Space/Escape and live compact/wide resize PASS";
                    app.exit(0);
                });
            });
        });
    }
    if (parser.isSet("arrows-smoke")) {
        auto *window = qobject_cast<QQuickWindow*>(engine.rootObjects().first());
        if (!window) return 40;
        // The compact viewport has two visual columns. Validate *real*
        // QQuickWindow key delivery and C++ proxy selection, not an isolated JS helper.
        window->resize(1280, 720);
        QTimer::singleShot(900, &app, [&, window] {
            auto *gallery = window->findChild<QQuickItem*>("fleetGallery");
            auto *table = window->findChild<QQuickItem*>("fleetTable");
            auto *search = window->findChild<QQuickItem*>("fleetSearchField");
            if (!gallery || !table || !search || gallery->width() <= 0 ||
                !gallery->property("cellWidth").isValid()) {
                qCritical() << "Missing keyboard navigation views"; app.exit(41); return;
            }
            fleet.clearSelection();
            gallery->forceActiveFocus(Qt::TabFocusReason);
            auto press = [&](Qt::Key key, const QString &expected, int error) {
                QTest::keyClick(window, key);
                QCoreApplication::processEvents();
                if (fleet.selectedId() != expected) {
                    qCritical() << "Arrow did not select the correct C++ proxy ID:"
                                << key << "expected" << expected
                                << "actual" << fleet.selectedId();
                    app.exit(error); return false;
                }
                return true;
            };
            if (!press(Qt::Key_Right, "C002", 42) ||
                !press(Qt::Key_Right, "M001", 43) ||
                !press(Qt::Key_Down, "C001", 44) ||
                !press(Qt::Key_Left, "C003", 45) ||
                !press(Qt::Key_Up, "C002", 46)) return;
            // The read-only inspector follows visual navigation, and moving
            // within the first rows does not flick the Gallery independently.
            if (fleet.selectedName() != "Ford Ranger" ||
                gallery->property("contentY").toDouble() > 1.0) {
                qCritical() << "Inspector mismatch or stray scroll on arrow" ;
                app.exit(47); return;
            }
            // A keyboard-only Backtab/Tab round-trip must not trap focus.
            QTest::keyClick(window, Qt::Key_Backtab);
            QCoreApplication::processEvents();
            if (gallery->hasActiveFocus()) {
                qCritical() << "Shift+Tab trapped focus inside Fleet Gallery";
                app.exit(48); return;
            }
            QTest::keyClick(window, Qt::Key_Tab);
            QCoreApplication::processEvents();
            if (!gallery->hasActiveFocus()) {
                qCritical() << "Tab failed to return to Gallery focus scope";
                app.exit(49); return;
            }
            // Input caret arrow is NOT a vehicle selection shortcut.
            search->forceActiveFocus(Qt::TabFocusReason);
            QTest::keyClick(window, Qt::Key_Down);
            QCoreApplication::processEvents();
            if (fleet.selectedId() != "C002") {
                qCritical() << "Search input stole vehicle arrow handling";
                app.exit(50); return;
            }
            window->setProperty("gallery", false);
            table->forceActiveFocus(Qt::TabFocusReason);
            if (!press(Qt::Key_Down, "M001", 51) ||
                !press(Qt::Key_Down, "C003", 52) ||
                !press(Qt::Key_Up, "M001", 53)) return;
            fleet.setStatus("Available");
            if (fleet.selectedVisibleIndex() != 0) {
                qCritical() << "Filtered table did not retain visible Honda ID";
                app.exit(54); return;
            }
            fleet.selectById("C002"); // The rented Ranger is now filtered out.
            if (fleet.selectedVisibleIndex() != -1 ||
                !press(Qt::Key_Down, "M001", 55)) return;
            qInfo() << "P2 REAL QML arrow navigation / Tab/Backtab / no stray Gallery scrolling PASS";
            app.exit(0);
        });
    }
    if (parser.isSet("focus-edges-smoke")) {
        auto *window = qobject_cast<QQuickWindow*>(engine.rootObjects().first());
        if (!window) return 60;
        window->resize(1280, 720);
        QTimer::singleShot(900, &app, [&, window] {
            auto *gallery = window->findChild<QQuickItem*>("fleetGallery");
            auto *table = window->findChild<QQuickItem*>("fleetTable");
            auto *search = window->findChild<QQuickItem*>("fleetSearchField");
            if (!gallery || !table || !search) {
                qCritical() << "Missing real QML Fleet collections"; app.exit(61); return;
            }
            const auto step = [&](Qt::Key key, const QString &id, int error) {
                QTest::keyClick(window, key);
                QCoreApplication::processEvents();
                if (fleet.selectedId() != id) {
                    qCritical() << "Focus edge mismatch" << key << id << fleet.selectedId();
                    app.exit(error); return false;
                }
                return true;
            };
            // A user who filters out the inspected Ranger must no longer see
            // an Inspector for an invisible record.
            fleet.selectById("C002");
            fleet.setStatus("Available");
            if (!fleet.selectedId().isEmpty()) {
                // rowCount is a model method, not a Qt property.
                qCritical() << "Filtered-out selection was not dismissed";
                app.exit(62); return;
            }
            fleet.selectById("C001");
            fleet.setSortBy("Rate");
            QTest::qWait(90);
            gallery->forceActiveFocus(Qt::TabFocusReason);
            QCoreApplication::processEvents();
            if (fleet.selectedVisibleIndex() != 3 ||
                gallery->property("currentIndex").toInt() != 3) {
                qCritical() << "Sort left gallery focus on incorrect vehicle row"
                            << fleet.selectedVisibleIndex()
                            << gallery->property("currentIndex").toInt();
                app.exit(63); return;
            }
            if (!step(Qt::Key_Left, "C003", 64) ||
                !step(Qt::Key_Right, "C001", 65)) return;
            const qreal scrollBefore = gallery->property("contentY").toDouble();
            if (!step(Qt::Key_Right, "C001", 66) ||
                std::abs(gallery->property("contentY").toDouble()-scrollBefore)>1.1) {
                qCritical() << "Right boundary must not wrap or scroll";
                app.exit(67); return;
            }
            // Matching and empty search both reconcile the Inspector; Up
            // with no records may neither select nor scroll.
            fleet.setQuery("Toyota");
            QTest::qWait(60);
            if (fleet.selectedId() != "C001" ||
                fleet.selectedVisibleIndex() != 0 ||
                gallery->property("currentIndex").toInt() != 0) {
                qCritical() << "Matching query did not preserve stable vehicle ID";
                app.exit(68); return;
            }
            fleet.setQuery("no-such-demo-vehicle");
            QTest::qWait(60);
            if (!fleet.selectedId().isEmpty() ||
                gallery->property("count").toInt() != 0 ||
                !step(Qt::Key_Down, QString(), 69)) {
                qCritical() << "Empty query left selected stale vehicle";
                app.exit(70); return;
            }
            fleet.setQuery("");
            fleet.setStatus("All");
            fleet.setSortBy("Name");
            window->resize(1500, 860); // Three visual Gallery columns.
            QTest::qWait(100);
            fleet.selectById("C002");
            gallery->forceActiveFocus(Qt::TabFocusReason);
            QTest::qWait(60);
            const int columns = qRound(gallery->width() /
                                       gallery->property("cellWidth").toDouble());
            if (columns != 3 ||
                !step(Qt::Key_Down, "C001", 71) ||
                !step(Qt::Key_Left, "C001", 72) ||
                !step(Qt::Key_Right, "M002", 73)) {
                qCritical() << "Responsive grid direction wrong:" << columns;
                app.exit(74); return;
            }
            search->forceActiveFocus(Qt::TabFocusReason);
            if (!step(Qt::Key_Left, "M002", 75)) return;
            qInfo() << "P2 real Qt Grid/Table focus boundary, filtered Inspector,"
                       " sort-ID sync and responsive grid PASS";
            app.exit(0);
        });
    }
    if (parser.isSet("rentals-smoke")) {
        auto *window = qobject_cast<QQuickWindow*>(engine.rootObjects().first());
        if (!window) { qCritical() << "P3-F root is not native Qt Quick"; return 80; }

        const bool compact = parser.isSet("compact");
        window->resize(compact ? 1280 : 1500, compact ? 720 : 860);
        window->setProperty("workspace", 2);
        QTimer::singleShot(1050, &app, [&, window, compact] {
            auto *list = window->findChild<QQuickItem*>("rentalList");
            auto *selection = window->findChild<QQuickItem*>("rentalSelectionText");
            if (!list || !selection || !list->isVisible() ||
                rentalModel.count() != 2 || list->property("count").toInt() != 2) {
                qCritical() << "P3-F real QML Rentals list/count absent"
                            << list << selection << rentalModel.count();
                app.exit(81); return;
            }

            const auto findRentalRow = [](const auto &self, QQuickItem *item,
                                          const QString &id) -> QQuickItem* {
                if (!item) return nullptr;
                if (item->objectName() == "rentalRow" &&
                    item->property("rentalId").toString() == id &&
                    item->isVisible()) return item;
                for (QQuickItem *child : item->childItems()) {
                    if (auto *found = self(self, child, id)) return found;
                }
                return nullptr;
            };
            auto *activeRow = findRentalRow(findRentalRow, list, "R001");
            auto *returnedRow = findRentalRow(findRentalRow, list, "R002");
            if (!activeRow || !returnedRow ||
                activeRow->property("status").toString() != "Active" ||
                returnedRow->property("status").toString() != "Returned") {
                qCritical() << "P3-F real QML delegates did not bind domain status";
                app.exit(82); return;
            }
            activeRow->forceActiveFocus(Qt::TabFocusReason);
            QTest::keyClick(window, Qt::Key_Space);
            QCoreApplication::processEvents();
            if (rentalModel.selectedRentalId() != "R001" ||
                !selection->property("text").toString().contains("R001")) {
                qCritical() << "P3-F keyboard selection not synced with QML"
                            << rentalModel.selectedRentalId();
                app.exit(83); return;
            }
            // Fleet is also a snapshot; its availability must NOT change
            // until explicit success-triggered refresh, just like Rentals.
            fleet.selectById("C001");
            if (fleet.availableCount() != 4 || !fleet.selectedAvailable()) {
                qCritical() << "P3-G pre-commit Fleet snapshot inconsistent";
                app.exit(92); return;
            }
            const QString sizeLabel = compact ? "1280x720" : "1500x860";
            const QImage shot = window->grabWindow();
            const QSize expected(compact ? 1280 : 1500, compact ? 720 : 860);
            if (shot.isNull() || shot.size() != expected ||
                !shot.save("p3-qt-rentals-" + sizeLabel + ".png", "PNG")) {
                qCritical() << "P3-F real QML screenshot invalid" << shot.size();
                app.exit(84); return;
            }

            // The UI has NO write controls. This explicit test-only C++
            // command acts on the disposable SHA-pinned fictional fixture.
            // It must not optimistically change the read model before refresh.
            RentalQuoteService quotes(system);
            const auto quote = quotes.preview("C001", 3);
            if (!quote.ok()) {
                qCritical() << "P3-F domain quote not available";
                app.exit(85); return;
            }
            const RentalConfirmationRequest request{
                *quote.quote, "Fictional Preview Customer", "0000000000"
            };
            const auto committed = RentalConfirmService(system).confirm(request);
            if (!committed.ok() || committed.receipt->rentalId != "R003" ||
                rentalModel.count() != 2 || list->property("count").toInt() != 2 ||
                fleet.availableCount() != 4 || !fleet.selectedAvailable()) {
                qCritical() << "P3-F/G commit/refresh boundary failed"
                            << committed.ok() << rentalModel.count();
                app.exit(86); return;
            }

            // One explicit C++ commit-success integration point updates both
            // read models. No QObject refresh is connected to a QML action.
            rentalModel.refresh();
            fleet.refreshAfterCommit();
            QTest::qWait(180);
            QCoreApplication::processEvents();
            if (rentalModel.count() != 3 || list->property("count").toInt() != 3 ||
                rentalModel.selectedRentalId() != "R001" ||
                !findRentalRow(findRentalRow, list, "R003") ||
                fleet.availableCount() != 3 || fleet.selectedAvailable() ||
                fleet.selectedId() != "C001") {
                qCritical() << "P3-F/G QML and Fleet disagree after committed rental";
                app.exit(87); return;
            }

            // The availability filter must now hide the freshly rented
            // vehicle, and the Fleet Inspector must not retain a hidden ID.
            fleet.setStatus("Available");
            if (!fleet.selectedId().isEmpty() ||
                static_cast<FleetProxy*>(fleet.visibleModel())->rowCount() != 3) {
                qCritical() << "P3-G refreshed available filter/selection stale";
                app.exit(93); return;
            }
            fleet.setStatus("All");

            if (!system.archiveRental("R002")) {
                qCritical() << "P3-F fictional returned rental could not archive";
                app.exit(88); return;
            }
            returnedRow = findRentalRow(findRentalRow, list, "R002");
            if (!returnedRow || returnedRow->property("status").toString() != "Returned") {
                qCritical() << "P3-F QML changed before archive refresh";
                app.exit(89); return;
            }
            rentalModel.refresh();
            QTest::qWait(180);
            returnedRow = findRentalRow(findRentalRow, list, "R002");
            if (!returnedRow ||
                returnedRow->property("status").toString() != "Archived" ||
                rentalModel.selectedRentalId() != "R001") {
                qCritical() << "P3-F archive state/selection QML sync failed";
                app.exit(90); return;
            }

            QByteArray afterVehicles, afterRentals;
            if (!readFile(vehicles, &afterVehicles) ||
                !readFile(rentals, &afterRentals) ||
                beforeVehicles != afterVehicles || beforeRentals != afterRentals) {
                qCritical() << "P3-F SHA-pinned demo fixtures were modified";
                app.exit(91); return;
            }
            qInfo() << "P3-F/G REAL QML Rentals and Fleet PASS:" << sizeLabel
                    << "keyboard selection, committed booking, both explicit"
                    << " model refreshes, Fleet availability/filter/Inspector,"
                    << " archived history, source-fixture protection";
            app.exit(0);
        });
    }
    if (parser.isSet("rentals-filter-smoke")) {
        auto *window = qobject_cast<QQuickWindow*>(engine.rootObjects().first());
        if (!window) return 100;
        const bool compact = parser.isSet("compact");
        window->resize(compact ? 1280 : 1500, compact ? 720 : 860);
        window->setProperty("workspace", 2);
        QTimer::singleShot(1000, &app, [&, window, compact] {
            auto *list = window->findChild<QQuickItem*>("rentalList");
            auto *selected = window->findChild<QQuickItem*>("rentalSelectionText");
            const auto findVisual = [](const auto &self, QQuickItem *item,
                                       const QString &name) -> QQuickItem* {
                if (!item) return nullptr;
                if (item->objectName()==name && item->isVisible()) return item;
                for (auto *child : item->childItems()) {
                    if (auto *found=self(self, child, name)) return found;
                }
                return nullptr;
            };
            auto *activeButton = findVisual(findVisual, window->contentItem(),
                                             "rentalFilterActive");
            auto *historyButton = findVisual(findVisual, window->contentItem(),
                                              "rentalFilterHistory");
            auto *allButton = findVisual(findVisual, window->contentItem(),
                                          "rentalFilterAll");
            if (!list || !list->isVisible() || !selected ||
                !activeButton || !historyButton || !allButton ||
                rentalModel.count()!=2 || list->property("count").toInt()!=2) {
                qCritical() << "P3-H real filter/list QML controls absent";
                app.exit(101); return;
            }
            const auto press = [window](QQuickItem *item) {
                item->forceActiveFocus(Qt::TabFocusReason);
                QTest::keyClick(window,Qt::Key_Space);
                QCoreApplication::processEvents();
                QTest::qWait(70);
            };
            list->forceActiveFocus(Qt::TabFocusReason);
            QTest::keyClick(window,Qt::Key_Down);
            QCoreApplication::processEvents();
            if (rentalModel.selectedRentalId()!="R001" ||
                rentalModel.selectedRow()!=0 || !selected->property("text").toString().contains("R001")) {
                qCritical() << "P3-H rental arrow did not select first visible ID";
                app.exit(102); return;
            }
            press(historyButton);
            if (rentalModel.statusFilter()!="History" || rentalModel.count()!=1 ||
                list->property("count").toInt()!=1 ||
                !rentalModel.selectedRentalId().isEmpty() ||
                rentalModel.data(rentalModel.index(0,0),RentalListModel::RentalIdRole).toString()!="R002") {
                qCritical() << "P3-H keyboard History filter or hidden selection failed";
                app.exit(103); return;
            }
            list->forceActiveFocus(Qt::TabFocusReason);
            QTest::keyClick(window,Qt::Key_Down);
            QCoreApplication::processEvents();
            if (rentalModel.selectedRentalId()!="R002" ||
                rentalModel.selectedRow()!=0) {
                qCritical() << "P3-H history list arrow selection failed";
                app.exit(104); return;
            }
            const QString suffix = compact?"1280x720":"1500x860";
            const QImage historyShot=window->grabWindow();
            if (historyShot.isNull() ||
                historyShot.size()!=QSize(compact?1280:1500,compact?720:860) ||
                !historyShot.save("p3-qt-rentals-history-"+suffix+".png","PNG")) {
                qCritical() << "P3-H real History QML screenshot failed" << historyShot.size();
                app.exit(105); return;
            }
            // Returned and archived records must both stay in History after a
            // real C++ domain operation and explicit model refresh.
            if (!system.archiveRental("R002")) {
                qCritical() << "P3-H fictional archive failed";
                app.exit(106); return;
            }
            if (rentalModel.data(rentalModel.index(0,0),RentalListModel::StatusRole).toString()!="Returned") {
                qCritical() << "P3-H History was optimistically updated";
                app.exit(107); return;
            }
            rentalModel.refresh();
            QCoreApplication::processEvents();
            if (rentalModel.statusFilter()!="History" || rentalModel.count()!=1 ||
                rentalModel.selectedRentalId()!="R002" ||
                rentalModel.data(rentalModel.index(0,0),RentalListModel::StatusRole).toString()!="Archived") {
                qCritical() << "P3-H archived record left History or lost selection";
                app.exit(108); return;
            }
            press(activeButton);
            if (rentalModel.statusFilter()!="Active" || rentalModel.count()!=1 ||
                rentalModel.selectedRentalId()!="" ||
                rentalModel.data(rentalModel.index(0,0),RentalListModel::RentalIdRole).toString()!="R001") {
                qCritical() << "P3-H Active filter and selection dismissal failed";
                app.exit(109); return;
            }
            // No hidden selection is resurrected on All.
            press(allButton);
            if (rentalModel.statusFilter()!="All" || rentalModel.count()!=2 ||
                !rentalModel.selectedRentalId().isEmpty()) {
                qCritical() << "P3-H All filter resurrected hidden selection";
                app.exit(110); return;
            }
            QByteArray originalFleet, originalRentals;
            if (!readFile(vehicles,&originalFleet) || !readFile(rentals,&originalRentals) ||
                originalFleet!=beforeVehicles || originalRentals!=beforeRentals) {
                qCritical() << "P3-H source SHA-pinned fictional fixtures mutated";
                app.exit(111); return;
            }
            qInfo() << "P3-H REAL QML Active/History/All PASS" << suffix
                    << "focus, keyboard filter, arrows, stable IDs, archive"
                    << " refresh, protected source demo bytes";
            app.exit(0);
        });
    }
    if (parser.isSet("rentals-return-smoke")) {
        auto *window=qobject_cast<QQuickWindow*>(engine.rootObjects().first());
        if (!window) return 120;
        const bool compact=parser.isSet("compact");
        window->resize(compact?1280:1500,compact?720:860);
        window->setProperty("workspace",2);
        QTimer::singleShot(1050,&app,[&,window,compact] {
            const auto findVisual=[](const auto &self,QQuickItem *item,
                                     const QString &name) -> QQuickItem* {
                if (!item) return nullptr;
                if (item->objectName()==name && item->isVisible()) return item;
                for (QQuickItem *child:item->childItems()) {
                    if (auto *found=self(self,child,name)) return found;
                }
                return nullptr;
            };
            auto *list=findVisual(findVisual,window->contentItem(),"rentalList");
            auto *returnButton=findVisual(findVisual,window->contentItem(),"rentalReturnButton");
            if (!list || !returnButton || returnButton->isEnabled()) {
                qCritical()<<"P3-I return button missing or enabled with no selection";
                app.exit(121);return;
            }
            const QByteArray originalTempRentals=[](const QString &file){
                QFile f(file); if (!f.open(QIODevice::ReadOnly)) return QByteArray();
                return f.readAll();
            }(disposable.filePath("rentals.txt"));
            const auto press=[&](QQuickItem *control) {
                control->forceActiveFocus(Qt::TabFocusReason);
                QTest::keyClick(window,Qt::Key_Space);
                QCoreApplication::processEvents();
                QTest::qWait(70);
            };
            list->forceActiveFocus(Qt::TabFocusReason);
            QTest::keyClick(window,Qt::Key_Down);
            QCoreApplication::processEvents();
            if (rentalModel.selectedRentalId()!="R001" ||
                !returnButton->isEnabled() || fleet.availableCount()!=4) {
                qCritical()<<"P3-I selected active rental not eligible";
                app.exit(122);return;
            }
            press(returnButton);
            auto *cancel=findVisual(findVisual,window->contentItem(),"rentalReturnCancel");
            if (!cancel) {
                qCritical()<<"P3-I native confirmation dialog did not appear";
                app.exit(123);return;
            }
            press(cancel);
            if (!rentalActions.canReturnSelected() ||
                rentalModel.selectedRentalId()!="R001" ||
                !system.findVehicleById("C002")->getIsRented() ||
                fleet.availableCount()!=4) {
                qCritical()<<"P3-I dialog Cancel mutated domain/view";
                app.exit(124);return;
            }
            QByteArray tempAfterCancel;
            if (!readFile(disposable.filePath("rentals.txt"),&tempAfterCancel) ||
                tempAfterCancel!=originalTempRentals) {
                qCritical()<<"P3-I Cancel wrote a file";
                app.exit(125);return;
            }
            press(returnButton);
            auto *confirm=findVisual(findVisual,window->contentItem(),"rentalReturnConfirm");
            if (!confirm || !confirm->isEnabled()) {
                qCritical()<<"P3-I native confirmed action not available";
                app.exit(126);return;
            }
            press(confirm);
            QTest::qWait(150);
            if (rentalModel.selectedRentalId()!="R001" ||
                rentalActions.canReturnSelected() || returnButton->isEnabled() ||
                fleet.availableCount()!=5 ||
                rentalModel.data(rentalModel.index(0,0),
                                 RentalListModel::StatusRole).toString()!="Returned" ||
                system.findVehicleById("C002")->getIsRented() ||
                !system.findRentalById("R001")->getIsReturned()) {
                qCritical()<<"P3-I committed return did not refresh real QML models"
                           <<rentalModel.selectedRentalId()<<fleet.availableCount();
                app.exit(127);return;
            }
            if (rentalActions.returnSelected() ||
                fleet.availableCount()!=5 || !system.findRentalById("R001")->getIsReturned()) {
                qCritical()<<"P3-I repeated return not safely rejected";
                app.exit(128);return;
            }
            rentalModel.setStatusFilter("Active");
            if (rentalModel.count()!=0 || !rentalModel.selectedRentalId().isEmpty()) {
                qCritical()<<"P3-I returned contract not removed from Active";
                app.exit(129);return;
            }
            rentalModel.setStatusFilter("History");
            if (rentalModel.count()!=2 ||
                rentalModel.data(rentalModel.index(0,0),
                                 RentalListModel::StatusRole).toString()!="Returned") {
                qCritical()<<"P3-I returned contract absent from History";
                app.exit(130);return;
            }
            QByteArray afterVehicles,afterRentals,persistedLedger;
            if (!readFile(vehicles,&afterVehicles) ||
                !readFile(rentals,&afterRentals) ||
                !readFile(disposable.filePath("rentals.txt"),&persistedLedger) ||
                afterVehicles!=beforeVehicles || afterRentals!=beforeRentals ||
                persistedLedger==originalTempRentals) {
                qCritical()<<"P3-I protected demo input or persistence incorrect";
                app.exit(131);return;
            }
            const QString size=compact?"1280x720":"1500x860";
            QImage screenshot=window->grabWindow();
            if (screenshot.isNull() ||
                screenshot.size()!=QSize(compact?1280:1500,compact?720:860) ||
                !screenshot.save("p3-qt-rentals-return-"+size+".png","PNG")) {
                qCritical()<<"P3-I real QML return screenshot failed";
                app.exit(132);return;
            }
            qInfo()<<"P3-I QML confirmed return PASS" <<size
                   <<"Cancel, real persisted domain return, Fleet/Rentals parity,"
                   <<"no repeated return, history and protected demo data";
            app.exit(0);
        });
    }
    if (parser.isSet("rentals-booking-smoke")) {
        auto *window=qobject_cast<QQuickWindow*>(engine.rootObjects().first());
        if (!window) return 150;
        const bool compact=parser.isSet("compact");
        window->resize(compact?1280:1500,compact?720:860);
        window->setProperty("workspace",2);
        QTimer::singleShot(1200,&app,[&,window,compact]{
            const auto find=[](const auto &self,QQuickItem *item,
                                const QString &name)->QQuickItem* {
                if(!item)return nullptr;
                if(item->objectName()==name && item->isVisible())return item;
                for(auto *child:item->childItems())
                    if(auto *candidate=self(self,child,name))return candidate;
                return nullptr;
            };
            auto *root=window->contentItem();
            auto *newButton=find(find,root,"rentalNewBookingButton");
            if(!newButton || rentalModel.count()!=2 || fleet.availableCount()!=4) {
                qCritical()<<"P3 guided booking launch source invalid";
                app.exit(151);return;
            }
            const auto press=[&](QQuickItem *item){
                item->forceActiveFocus(Qt::TabFocusReason);
                QTest::keyClick(window,Qt::Key_Space);
                QCoreApplication::processEvents();
                QTest::qWait(70);
            };
            press(newButton);
            auto *vehicle=find(find,root,"bookingVehicleId");
            auto *preview=find(find,root,"bookingPreviewButton");
            auto *cancel=find(find,root,"bookingCancelButton");
            auto *confirm=find(find,root,"bookingConfirmButton");
            if(!vehicle||!preview||!cancel||!confirm||confirm->isEnabled()) {
                qCritical()<<"P3 real guided QML booking inputs missing";
                app.exit(152);return;
            }
            vehicle->forceActiveFocus(Qt::TabFocusReason);
            QTest::keyClick(window,Qt::Key_C);
            QTest::keyClick(window,Qt::Key_0);
            QTest::keyClick(window,Qt::Key_0);
            QTest::keyClick(window,Qt::Key_3);
            press(preview);
            if(!bookingActions.canConfirm() ||
                bookingActions.reviewedVehicleId()!="C003" ||
                !bookingActions.quoteSummary().contains("Total R 800.00") ||
                !confirm->isEnabled()) {
                qCritical()<<"P3 C++ quote not reflected by QML" << bookingActions.quoteSummary();
                app.exit(153);return;
            }
            const QString suffix=compact?"1280x720":"1500x860";
            const auto image=window->grabWindow();
            if(image.isNull() || image.size()!=QSize(compact?1280:1500,compact?720:860) ||
                !image.save("p3-qt-rentals-booking-"+suffix+".png","PNG")) {
                qCritical()<<"P3 guided QML quote screenshot invalid";
                app.exit(154);return;
            }
            press(cancel);
            QByteArray tempLedger;
            if(bookingActions.canConfirm() || rentalModel.count()!=2 ||
               fleet.availableCount()!=4 ||
               !readFile(disposable.filePath("rentals.txt"),&tempLedger) ||
               tempLedger!=beforeRentals) {
                qCritical()<<"P3 Cancel changed authoritative domain or preview";
                app.exit(155);return;
            }
            press(newButton);
            vehicle=find(find,root,"bookingVehicleId");
            preview=find(find,root,"bookingPreviewButton");
            confirm=find(find,root,"bookingConfirmButton");
            auto *customer=find(find,root,"bookingCustomer");
            auto *phone=find(find,root,"bookingPhone");
            if(!vehicle||!preview||!confirm||!customer||!phone) {
                qCritical()<<"P3 re-opened quote dialog controls missing";
                app.exit(156);return;
            }
            // Vehicle ID remains from the canceled, never-committed preview.
            press(preview);
            customer->forceActiveFocus(Qt::TabFocusReason);
            // QtTest has no keyClicks(QWindow*, QString) overload.
            // Set fixture-only contact text; the live preview button and
            // confirmation still receive actual Qt keyboard events.
            customer->setProperty("text",QStringLiteral("Fictional Demo C"));
            phone->forceActiveFocus(Qt::TabFocusReason);
            for(int i=0;i<10;++i)QTest::keyClick(window,Qt::Key_0);
            if(!bookingActions.canConfirm() || !confirm->isEnabled()) {
                qCritical()<<"P3 refreshed quote unavailable";
                app.exit(157);return;
            }
            press(confirm);
            QTest::qWait(140);
            if(bookingActions.lastRentalId()!="R003" ||
               bookingActions.canConfirm() || rentalModel.count()!=3 ||
               fleet.availableCount()!=3 ||
               !system.findVehicleById("C003")->getIsRented() ||
               rentalModel.data(rentalModel.index(2,0),
                     RentalListModel::StatusRole).toString()!="Active") {
                qCritical()<<"P3 real booking commit did not refresh both models"
                           <<bookingActions.lastRentalId()<<fleet.availableCount()
                           <<rentalModel.count();
                app.exit(158);return;
            }
            QByteArray afterOriginalFleet,afterOriginalRentals,afterTempLedger;
            if(!readFile(vehicles,&afterOriginalFleet) || !readFile(rentals,&afterOriginalRentals) ||
               !readFile(disposable.filePath("rentals.txt"),&afterTempLedger) ||
               afterOriginalFleet!=beforeVehicles ||
               afterOriginalRentals!=beforeRentals ||
               afterTempLedger==beforeRentals) {
                qCritical()<<"P3 booking saved outside disposable input or was not persisted";
                app.exit(159);return;
            }
            qInfo()<<"P3 actual QML guided booking PASS"<<suffix
                    <<"C++ price/availability, Cancel, confirmed receipt,"
                    <<"no optimistic model write, dual-model refresh and SHA fixture guard";
            app.exit(0);
        });
    }
    if (parser.isSet("rentals-archive-smoke")) {
        auto *window=qobject_cast<QQuickWindow*>(engine.rootObjects().first());
        if(!window)return 170;
        const bool compact=parser.isSet("compact");
        window->resize(compact?1280:1500,compact?720:860);
        window->setProperty("workspace",2);
        QTimer::singleShot(1100,&app,[&,window,compact]{
            const auto find=[](const auto &self,QQuickItem *item,
                                const QString &name)->QQuickItem* {
                if(!item)return nullptr;
                if(item->objectName()==name && item->isVisible())return item;
                for(auto *child:item->childItems())
                    if(auto *candidate=self(self,child,name))return candidate;
                return nullptr;
            };
            auto *list=find(find,window->contentItem(),"rentalList");
            auto *archive=find(find,window->contentItem(),"rentalArchiveButton");
            if(!list||!archive||archive->isEnabled()){
                qCritical()<<"P3 archive button should be initially disabled";
                app.exit(171);return;
            }
            const auto press=[&](QQuickItem *item){
                item->forceActiveFocus(Qt::TabFocusReason);
                QTest::keyClick(window,Qt::Key_Space);
                QCoreApplication::processEvents();
                QTest::qWait(70);
            };
            list->forceActiveFocus(Qt::TabFocusReason);
            QTest::keyClick(window,Qt::Key_Down);
            QTest::keyClick(window,Qt::Key_Down);
            QCoreApplication::processEvents();
            if(rentalModel.selectedRentalId()!="R002"||!archiveActions.canArchiveSelected() ||
               !archive->isEnabled()){
                qCritical()<<"P3 archival returned selection not enabled";
                app.exit(172);return;
            }
            QByteArray initial;
            if(!readFile(disposable.filePath("rentals.txt"),&initial)){
                app.exit(173);return;
            }
            press(archive);
            auto *cancel=find(find,window->contentItem(),"rentalArchiveCancel");
            if(!cancel){qCritical()<<"P3 archive modal absent";app.exit(174);return;}
            press(cancel);
            QByteArray afterCancel;
            if(!readFile(disposable.filePath("rentals.txt"),&afterCancel)||
               afterCancel!=initial||!archiveActions.canArchiveSelected()){
                qCritical()<<"P3 cancel unexpectedly archived";
                app.exit(175);return;
            }
            press(archive);
            auto *confirm=find(find,window->contentItem(),"rentalArchiveConfirm");
            if(!confirm||!confirm->isEnabled()){
                qCritical()<<"P3 confirm archive unavailable";
                app.exit(176);return;
            }
            press(confirm);
            QTest::qWait(120);
            if(rentalModel.selectedRentalId()!="R002" ||
               archiveActions.canArchiveSelected() || archive->isEnabled() ||
               rentalModel.data(rentalModel.index(1,0),
                        RentalListModel::StatusRole).toString()!="Archived" ||
               !system.findRentalById("R002")->getIsArchived() ||
               fleet.availableCount()!=4 || archiveActions.archiveSelected()) {
                qCritical()<<"P3 archival commit/selection/status failed";
                app.exit(177);return;
            }
            rentalModel.setStatusFilter("History");
            if(rentalModel.count()!=1 || rentalModel.selectedRentalId()!="R002"){
                qCritical()<<"P3 archived history filter lost record";
                app.exit(178);return;
            }
            const QString suffix=compact?"1280x720":"1500x860";
            const QImage shot=window->grabWindow();
            if(shot.isNull()||shot.size()!=QSize(compact?1280:1500,compact?720:860) ||
               !shot.save("p3-qt-rentals-archive-"+suffix+".png","PNG")){
                qCritical()<<"P3 archived QML screenshot invalid";
                app.exit(179);return;
            }
            QByteArray sourceFleet,sourceRental,changed;
            if(!readFile(vehicles,&sourceFleet)||
               !readFile(rentals,&sourceRental)||
               !readFile(disposable.filePath("rentals.txt"),&changed)||
               sourceFleet!=beforeVehicles || sourceRental!=beforeRentals ||
               changed==initial){
                qCritical()<<"P3 archive affected source fixtures or did not save";
                app.exit(180);return;
            }
            qInfo()<<"P3 QML returned-rental archive PASS"<<suffix
                    <<"Cancel, persisted archive, selected History and no source writes";
            app.exit(0);
        });
    }
    if (parser.isSet("p4-shell-smoke")) {
        auto *window=qobject_cast<QQuickWindow*>(engine.rootObjects().first());
        if (!window) return 190;
        const bool compact=parser.isSet("compact");
        window->resize(compact?1280:1500,compact?720:860);
        window->setProperty("workspace",1);
        QTimer::singleShot(1200,&app,[&,window,compact] {
            const auto findVisible=[](const auto &self,QQuickItem *item,
                                      const QString &name)->QQuickItem*{
                if(!item)return nullptr;
                if(item->objectName()==name && item->isVisible())return item;
                for(QQuickItem *child:item->childItems())
                    if(auto *hit=self(self,child,name))return hit;
                return nullptr;
            };
            auto *root=window->contentItem();
            auto *fleetNav=findVisible(findVisible,root,"workspaceNavFleet");
            auto *rentalNav=findVisible(findVisible,root,"workspaceNavRentals");
            auto *overviewNav=findVisible(findVisible,root,"workspaceNavOverview");
            auto *search=findVisible(findVisible,root,"fleetSearchField");
            auto *gallery=findVisible(findVisible,root,"fleetGallery");
            auto *frame=findVisible(findVisible,root,"fleetGalleryFocus");
            if(!fleetNav||!rentalNav||!overviewNav||!search||!gallery||!frame) {
                qCritical()<<"P4 native component/navigation controls missing";
                app.exit(191);return;
            }
            rentalNav->forceActiveFocus(Qt::TabFocusReason);
            QTest::keyClick(window,Qt::Key_Up);
            QCoreApplication::processEvents();
            if(!fleetNav->hasActiveFocus() ||
               fleet.selectedId()!="") {
                qCritical()<<"P4 group Up changed business state or missed Fleet focus";
                app.exit(192);return;
            }
            QTest::keyClick(window,Qt::Key_Up);
            QCoreApplication::processEvents();
            if(!overviewNav->hasActiveFocus()) {
                qCritical()<<"P4 second group Up missed Overview";
                app.exit(193);return;
            }
            QTest::keyClick(window,Qt::Key_Up);
            if(!overviewNav->hasActiveFocus()) {
                qCritical()<<"P4 sidebar boundary wrapped";
                app.exit(194);return;
            }
            QTest::keyClick(window,Qt::Key_Down);
            QTest::keyClick(window,Qt::Key_Right);
            QTest::qWait(90);
            if(window->property("workspace").toInt()!=1 ||
               !search->hasActiveFocus()) {
                qCritical()<<"P4 Fleet Right did not enter Search";
                app.exit(195);return;
            }
            // The focused TextField owns its arrow keys, not Fleet selection.
            QTest::keyClick(window,Qt::Key_Right);
            QCoreApplication::processEvents();
            if(!search->hasActiveFocus() || !fleet.selectedId().isEmpty()) {
                qCritical()<<"P4 text input arrows were intercepted";
                app.exit(196);return;
            }
            gallery->forceActiveFocus(Qt::TabFocusReason);
            QTest::keyClick(window,Qt::Key_Down);
            QCoreApplication::processEvents();
            QTest::qWait(60);
            // The collection may already have a selected visible row.
            // Assert state agreement rather than assuming a specific ID.
            if(fleet.selectedId().isEmpty() ||
               !frame->property("keyboardFocused").toBool() ||
               !frame->property("selected").toBool()) {
                qCritical()<<"P4 shared Fleet focus/selection distinction missing"
                           <<fleet.selectedId()<<frame->property("keyboardFocused")
                           <<frame->property("selected");
                app.exit(197);return;
            }
            rentalNav->forceActiveFocus(Qt::TabFocusReason);
            QTest::keyClick(window,Qt::Key_Space);
            QCoreApplication::processEvents();
            if(window->property("workspace").toInt()!=2) {
                qCritical()<<"P4 workspace native Space activation failed";
                app.exit(198);return;
            }
            auto *rentalListItem=findVisible(findVisible,root,"rentalList");
            auto *returnButton=findVisible(findVisible,root,"rentalReturnButton");
            if(!rentalListItem||!returnButton) {
                qCritical()<<"P4 rental list or dialog action absent";
                app.exit(199);return;
            }
            rentalListItem->forceActiveFocus(Qt::TabFocusReason);
            QTest::keyClick(window,Qt::Key_Down);
            QCoreApplication::processEvents();
            if(rentalModel.selectedRentalId()!="R001" || !returnButton->isEnabled()) {
                qCritical()<<"P4 rental selection did not follow C++ visible rows";
                app.exit(200);return;
            }
            returnButton->forceActiveFocus(Qt::TabFocusReason);
            QTest::keyClick(window,Qt::Key_Space);
            QTest::qWait(80);
            const auto dialogIsVisible=[&] {
                auto *dialog=window->findChild<QObject*>("rentalReturnDialog");
                return dialog && dialog->property("visible").toBool();
            };
            if(!dialogIsVisible()) {
                qCritical()<<"P4 modal did not acquire topmost context";
                app.exit(201);return;
            }
            QTest::keyClick(window,Qt::Key_Escape);
            QTest::qWait(120);
            if(dialogIsVisible() || rentalModel.selectedRentalId()!="R001" ||
               !returnButton->hasActiveFocus() ||
               system.findRentalById("R001")->getIsReturned()) {
                qCritical()<<"P4 Escape cleared selection or failed modal restoration"
                           <<rentalModel.selectedRentalId()
                           <<returnButton->hasActiveFocus();
                app.exit(202);return;
            }
            const QString size=compact?"1280x720":"1500x860";
            const QImage image=window->grabWindow();
            if(image.isNull() ||
               image.size()!=QSize(compact?1280:1500,compact?720:860) ||
               !image.save("p4-qt-shared-focus-"+size+".png","PNG")) {
                qCritical()<<"P4 focus screenshot mismatch";
                app.exit(203);return;
            }
            QByteArray sourceVehicles,sourceRentals,temporaryRentals;
            if(!readFile(vehicles,&sourceVehicles) ||
               !readFile(rentals,&sourceRentals) ||
               !readFile(disposable.filePath("rentals.txt"),&temporaryRentals) ||
               sourceVehicles!=beforeVehicles || sourceRentals!=beforeRentals ||
               temporaryRentals!=beforeRentals) {
                qCritical()<<"P4 keyboard/modal test mutated fictional source or temp ledger";
                app.exit(204);return;
            }
            qInfo()<<"P4 real shared shell PASS"<<size
                   <<"sidebar Up/Down/Right, native Search, separate focus,"
                   <<"modal Escape priority/restored focus and no writes";
            app.exit(0);
        });
    }
    if (parser.isSet("p4-components-smoke")) {
        auto *window=qobject_cast<QQuickWindow*>(engine.rootObjects().first());
        if(!window) return 210;
        const bool compact=parser.isSet("compact");
        window->resize(compact?1280:1500,compact?720:860);
        window->setProperty("workspace",2);
        QTimer::singleShot(1200,&app,[&,window,compact] {
            const auto find=[](const auto &self,QQuickItem *item,
                               const QString &name)->QQuickItem* {
                if(!item)return nullptr;
                if(item->objectName()==name && item->isVisible())return item;
                for(auto *child:item->childItems())
                    if(auto *hit=self(self,child,name))return hit;
                return nullptr;
            };
            QQuickItem *root=window->contentItem();
            auto *newRental=find(find,root,"rentalNewBookingButton");
            if(!newRental) {qCritical()<<"P4 New Rental control missing";app.exit(211);return;}
            const auto press=[&](QQuickItem *item) {
                item->forceActiveFocus(Qt::TabFocusReason);
                QTest::keyClick(window,Qt::Key_Space);
                QTest::qWait(90);
            };
            press(newRental);
            auto *vehicle=find(find,root,"bookingVehicleId");
            auto *customer=find(find,root,"bookingCustomer");
            auto *phone=find(find,root,"bookingPhone");
            auto *quote=find(find,root,"bookingQuoteSummary");
            auto *cancel=find(find,root,"bookingCancelButton");
            if(!vehicle||!customer||!phone||!quote||!cancel ||
               vehicle->height()<43 || customer->height()<43 || phone->height()<43) {
                qCritical()<<"P4 reusable rental field/quote UI missing or too small";
                app.exit(212);return;
            }
            vehicle->forceActiveFocus(Qt::TabFocusReason);
            for(Qt::Key key : {Qt::Key_C,Qt::Key_0,Qt::Key_0,Qt::Key_1})
                QTest::keyClick(window,key);
            QTest::keyClick(window,Qt::Key_Left);
            QCoreApplication::processEvents();
            if(!vehicle->hasActiveFocus() ||
               vehicle->property("text").toString().toUpper()!="C001" ||
               !fleet.selectedId().isEmpty()) {
                qCritical()<<"P4 text caret or C++ selection changed unexpectedly";
                app.exit(213);return;
            }
            press(cancel);
            QTest::qWait(110);
            if(!newRental->hasActiveFocus() || bookingActions.canConfirm()) {
                qCritical()<<"P4 Booking Cancel focus/quote invalidation missing";
                app.exit(214);return;
            }
            auto *returnButton=find(find,root,"rentalReturnButton");
            if(!returnButton || !rentalModel.selectById("R001") ||
               !returnButton->isEnabled()) {
                qCritical()<<"P4 active fictional rental not selectable";
                app.exit(215);return;
            }
            press(returnButton);
            auto *returnCancel=find(find,root,"rentalReturnCancel");
            auto *returnConfirm=find(find,root,"rentalReturnConfirm");
            if(!returnCancel||!returnConfirm||!returnConfirm->isEnabled()) {
                qCritical()<<"P4 shared Return confirm/cancel controls unavailable";
                app.exit(216);return;
            }
            press(returnCancel);
            QTest::qWait(110);
            if(!returnButton->hasActiveFocus() ||
               system.findRentalById("R001")->getIsReturned() ||
               rentalModel.selectedRentalId()!="R001") {
                qCritical()<<"P4 Return Cancel changed domain/selection/focus";
                app.exit(217);return;
            }
            if(!rentalModel.selectById("R002")) {
                qCritical()<<"P4 returned demo rental absent";
                app.exit(218);return;
            }
            auto *archiveButton=find(find,root,"rentalArchiveButton");
            if(!archiveButton || !archiveButton->isEnabled()) {
                qCritical()<<"P4 Archive action not eligible";
                app.exit(219);return;
            }
            press(archiveButton);
            auto *archiveCancel=find(find,root,"rentalArchiveCancel");
            auto *archiveConfirm=find(find,root,"rentalArchiveConfirm");
            if(!archiveCancel||!archiveConfirm||!archiveConfirm->isEnabled()) {
                qCritical()<<"P4 shared Archive confirm/cancel controls unavailable";
                app.exit(220);return;
            }
            QTest::keyClick(window,Qt::Key_Escape);
            QTest::qWait(155);
            if(!archiveButton->hasActiveFocus() ||
               system.findRentalById("R002")->getIsArchived() ||
               rentalModel.selectedRentalId()!="R002") {
                qCritical()<<"P4 Archive Escape stole selection/changed domain";
                app.exit(221);return;
            }
            QByteArray vehiclesNow,rentalsNow,tempRentalsNow;
            if(!readFile(vehicles,&vehiclesNow) ||
               !readFile(rentals,&rentalsNow) ||
               !readFile(disposable.filePath("rentals.txt"),&tempRentalsNow) ||
               vehiclesNow!=beforeVehicles || rentalsNow!=beforeRentals ||
               tempRentalsNow!=beforeRentals) {
                qCritical()<<"P4 Cancel/Escape wrote domain or demo ledger";
                app.exit(222);return;
            }
            const QString size=compact?"1280x720":"1500x860";
            const QImage shot=window->grabWindow();
            if(shot.isNull() ||
               shot.size()!=QSize(compact?1280:1500,compact?720:860) ||
               !shot.save("p4-qt-shared-components-"+size+".png","PNG")) {
                qCritical()<<"P4 reusable component screenshot mismatch";
                app.exit(223);return;
            }
            qInfo()<<"P4 shared field, domain message, Return/Archive modal PASS"
                   <<size<<"keyboard Cancel/Escape and no writes";
            app.exit(0);
        });
    }
    if (parser.isSet("p4-tab-smoke")) {
        auto *window=qobject_cast<QQuickWindow*>(engine.rootObjects().first());
        if (!window) return 230;
        const bool compact=parser.isSet("compact");
        window->resize(compact?1280:1500,compact?720:860);
        window->setProperty("workspace",1);
        QTimer::singleShot(1250,&app,[&,window,compact]{
            const auto find=[](const auto &self,QQuickItem *item,
                               const QString &name)->QQuickItem* {
                if(!item)return nullptr;
                if(item->objectName()==name && item->isVisible())return item;
                for(QQuickItem *child:item->childItems())
                    if(auto *hit=self(self,child,name))return hit;
                return nullptr;
            };
            auto *root=window->contentItem();
            auto *search=find(find,root,"fleetSearchField");
            auto *status=find(find,root,"fleetStatusCombo");
            auto *sort=find(find,root,"fleetSortCombo");
            if(!search||!status||!sort) {
                qCritical()<<"P4 Fleet tab controls not found";
                app.exit(231);return;
            }
            search->forceActiveFocus(Qt::TabFocusReason);
            QTest::keyClick(window,Qt::Key_Tab);
            QCoreApplication::processEvents();
            if(!status->hasActiveFocus()) {
                qCritical()<<"P4 Tab search to status failed";
                app.exit(232);return;
            }
            QTest::keyClick(window,Qt::Key_Tab);
            QCoreApplication::processEvents();
            if(!sort->hasActiveFocus()) {
                qCritical()<<"P4 Tab status to sort failed";
                app.exit(233);return;
            }
            QTest::keyClick(window,Qt::Key_Backtab);
            QCoreApplication::processEvents();
            if(!status->hasActiveFocus()) {
                qCritical()<<"P4 Shift+Tab sort to status failed";
                app.exit(234);return;
            }
            QTest::keyClick(window,Qt::Key_Backtab);
            QCoreApplication::processEvents();
            if(!search->hasActiveFocus()) {
                qCritical()<<"P4 Shift+Tab status to search failed";
                app.exit(235);return;
            }
            QTest::keyClick(window,Qt::Key_Left);
            if(!search->hasActiveFocus()||!fleet.selectedId().isEmpty()) {
                qCritical()<<"P4 TextField Left intercepted";
                app.exit(236);return;
            }
            // An invisible Fleet selection must survive Escape on Overview.
            // Only the visible workspace may own selection-dismissal.
            fleet.selectById("C001");
            if(fleet.selectedId()!="C001") {
                qCritical()<<"P4 fictional Fleet selection setup failed";
                app.exit(253);return;
            }
            window->setProperty("workspace",0);
            QCoreApplication::processEvents();
            if(window->property("canDismissSelection").toBool()) {
                qCritical()<<"P4 Overview captured hidden selection dismissal";
                app.exit(254);return;
            }
            QTest::keyClick(window,Qt::Key_Escape);
            QCoreApplication::processEvents();
            if(window->property("workspace").toInt()!=0 ||
               fleet.selectedId()!="C001") {
                qCritical()<<"P4 Overview Escape cleared hidden Fleet record";
                app.exit(255);return;
            }
            window->setProperty("workspace",1);
            QCoreApplication::processEvents();
            if(!window->property("canDismissSelection").toBool()) {
                qCritical()<<"P4 Fleet selected record cannot be dismissed";
                app.exit(256);return;
            }
            QTest::keyClick(window,Qt::Key_Escape);
            QCoreApplication::processEvents();
            if(!fleet.selectedId().isEmpty() ||
               window->property("canDismissSelection").toBool()) {
                qCritical()<<"P4 visible Fleet Escape failed to dismiss selection";
                app.exit(257);return;
            }
            // Switch to actual rentals UI using a keyboard-activated sidebar.
            auto *rentalNav=find(find,root,"workspaceNavRentals");
            if(!rentalNav){app.exit(237);return;}
            rentalNav->forceActiveFocus(Qt::TabFocusReason);
            QTest::keyClick(window,Qt::Key_Space);
            QTest::qWait(70);
            if(window->property("workspace").toInt()!=2 ||
               !rentalModel.selectById("R001")) {
                qCritical()<<"P4 keyboard workspace change or selected ID";
                app.exit(238);return;
            }
            // One Tab stop for the Rentals collection, not every row.
            auto *rentalsList=find(find,root,"rentalList");
            auto *rentalRow=find(find,root,"rentalRow");
            if(!rentalsList || !rentalRow ||
               !rentalsList->property("activeFocusOnTab").toBool() ||
               rentalRow->property("activeFocusOnTab").toBool()) {
                qCritical()<<"P4 Rentals collection/delegate Tab policy violated";
                app.exit(251);return;
            }
            rentalsList->forceActiveFocus(Qt::TabFocusReason);
            QTest::keyClick(window,Qt::Key_Tab);
            QCoreApplication::processEvents();
            if(rentalRow->hasActiveFocus()) {
                qCritical()<<"P4 Tab incorrectly entered an individual rental row";
                app.exit(252);return;
            }
            auto *returnButton=find(find,root,"rentalReturnButton");
            if(!returnButton || !returnButton->isEnabled()) {
                app.exit(239);return;
            }
            returnButton->forceActiveFocus(Qt::TabFocusReason);
            QTest::keyClick(window,Qt::Key_Space);
            QTest::qWait(120);
            auto *cancel=find(find,root,"rentalReturnCancel");
            auto *confirm=find(find,root,"rentalReturnConfirm");
            if(!cancel||!confirm||!cancel->hasActiveFocus() ||
               !confirm->isEnabled()) {
                qCritical()<<"P4 modal initial Cancel focus failed";
                app.exit(240);return;
            }
            QTest::keyClick(window,Qt::Key_Tab);
            QCoreApplication::processEvents();
            if(!confirm->hasActiveFocus()) {
                qCritical()<<"P4 modal Tab did not remain within dialog";
                app.exit(241);return;
            }
            QTest::keyClick(window,Qt::Key_Backtab);
            QCoreApplication::processEvents();
            if(!cancel->hasActiveFocus()) {
                qCritical()<<"P4 modal Shift+Tab failed";
                app.exit(242);return;
            }
            QTest::keyClick(window,Qt::Key_Backtab);
            QCoreApplication::processEvents();
            if(!confirm->hasActiveFocus()) {
                qCritical()<<"P4 modal reverse boundary escaped";
                app.exit(243);return;
            }
            QTest::keyClick(window,Qt::Key_Tab);
            QCoreApplication::processEvents();
            if(!cancel->hasActiveFocus()) {
                qCritical()<<"P4 modal forward boundary escaped";
                app.exit(244);return;
            }
            QTest::keyClick(window,Qt::Key_Escape);
            QTest::qWait(120);
            if(!returnButton->hasActiveFocus() ||
               rentalModel.selectedRentalId()!="R001" ||
               system.findRentalById("R001")->getIsReturned()) {
                qCritical()<<"P4 modal Escape changed business state or lost invoker";
                app.exit(245);return;
            }
            // Booking must open on first actual entry field, not background.
            auto *booking=find(find,root,"rentalNewBookingButton");
            if(!booking){app.exit(246);return;}
            booking->forceActiveFocus(Qt::TabFocusReason);
            QTest::keyClick(window,Qt::Key_Space);
            QTest::qWait(110);
            auto *vehicle=find(find,root,"bookingVehicleId");
            if(!vehicle||!vehicle->hasActiveFocus()) {
                qCritical()<<"P4 Booking initial vehicle field focus failed";
                app.exit(247);return;
            }
            QTest::keyClick(window,Qt::Key_Escape);
            QTest::qWait(120);
            if(!booking->hasActiveFocus()||bookingActions.canConfirm()){
                qCritical()<<"P4 booking Escape did not cancel preview/restore";
                app.exit(248);return;
            }
            QByteArray sourceFleet,sourceRental,tempRental;
            if(!readFile(vehicles,&sourceFleet) ||
               !readFile(rentals,&sourceRental) ||
               !readFile(disposable.filePath("rentals.txt"),&tempRental) ||
               sourceFleet!=beforeVehicles || sourceRental!=beforeRentals ||
               tempRental!=beforeRentals) {
                qCritical()<<"P4 Tab/ShiftTab flow modified fixture data";
                app.exit(249);return;
            }
            const QString size=compact?"1280x720":"1500x860";
            const QImage screenshot=window->grabWindow();
            if(screenshot.isNull()||
               screenshot.size()!=QSize(compact?1280:1500,compact?720:860)||
               !screenshot.save("p4-qt-focus-route-"+size+".png","PNG")) {
                qCritical()<<"P4 focus route screenshot invalid";
                app.exit(250);return;
            }
            qInfo()<<"P4 native focus route PASS"<<size
                   <<"Tab/ShiftTab Fleet, bounded modal, Booking focus/Escape, no writes";
            app.exit(0);
        });
    }
    if (parser.isSet("p4-a11y-smoke")) {
        auto *window=qobject_cast<QQuickWindow*>(engine.rootObjects().first());
        if (!window) return 270;
        const bool compact=parser.isSet("compact");
        window->resize(compact?1280:1500,compact?720:860);
        window->setProperty("workspace",1);
        QTimer::singleShot(1250,&app,[&,window,compact] {
            const auto find=[](const auto &self,QQuickItem *item,
                               const QString &name)->QQuickItem* {
                if (!item) return nullptr;
                if (item->objectName()==name && item->isVisible()) return item;
                for (auto *child:item->childItems())
                    if (auto *hit=self(self,child,name)) return hit;
                return nullptr;
            };
            auto *root=window->contentItem();
            const auto checkRadio=[&](const QString &id,const QString &expectedName,
                                      bool expectedChecked)->bool {
                auto *item=find(find,root,id);
                auto *iface=item ? QAccessible::queryAccessibleInterface(item) : nullptr;
                if (!iface || !iface->isValid() ||
                    iface->role()!=QAccessible::RadioButton ||
                    iface->text(QAccessible::Name)!=expectedName ||
                    iface->state().checked!=expectedChecked) {
                    qCritical()<<"P4 accessibility radio mismatch"<<id
                               <<expectedName<<expectedChecked
                               <<(iface ? iface->text(QAccessible::Name) : QStringLiteral("missing"))
                               <<(iface ? static_cast<int>(iface->role()) : -1);
                    return false;
                }
                return true;
            };
            // Side navigation must expose which workspace is current.
            if (!checkRadio("workspaceNavOverview","Overview workspace",false) ||
                !checkRadio("workspaceNavFleet","Fleet workspace",true) ||
                !checkRadio("workspaceNavRentals","Rentals workspace",false)) {
                app.exit(278);return;
            }
            auto *overviewNav=find(find,root,"workspaceNavOverview");
            overviewNav->forceActiveFocus(Qt::TabFocusReason);
            QTest::keyClick(window,Qt::Key_Space);
            QCoreApplication::processEvents();
            if (window->property("workspace").toInt()!=0 ||
                !checkRadio("workspaceNavOverview","Overview workspace",true) ||
                !checkRadio("workspaceNavFleet","Fleet workspace",false)) {
                qCritical()<<"P4 Overview workspace accessibility did not update";
                app.exit(279);return;
            }
            auto *fleetNav=find(find,root,"workspaceNavFleet");
            fleetNav->forceActiveFocus(Qt::TabFocusReason);
            QTest::keyClick(window,Qt::Key_Space);
            QCoreApplication::processEvents();
            if (window->property("workspace").toInt()!=1 ||
                !checkRadio("workspaceNavOverview","Overview workspace",false) ||
                !checkRadio("workspaceNavFleet","Fleet workspace",true)) {
                qCritical()<<"P4 Fleet workspace accessibility did not update";
                app.exit(280);return;
            }
            if (!checkRadio("fleetGalleryToggle","Fleet gallery view",true) ||
                !checkRadio("fleetTableToggle","Fleet table view",false)) {
                app.exit(271);return;
            }
            // These native input controls must have meaningful, public names.
            const auto checkName=[&](const QString &id,const QString &expected)->bool {
                auto *item=find(find,root,id);
                auto *iface=item ? QAccessible::queryAccessibleInterface(item) : nullptr;
                return iface && iface->isValid() &&
                       iface->text(QAccessible::Name)==expected;
            };
            if (!checkName("fleetSearchField","Search fleet") ||
                !checkName("fleetStatusCombo","Filter fleet status") ||
                !checkName("fleetSortCombo","Sort fleet")) {
                qCritical()<<"P4 native Fleet input accessible names absent";
                app.exit(272);return;
            }
            auto *table=find(find,root,"fleetTableToggle");
            table->forceActiveFocus(Qt::TabFocusReason);
            QTest::keyClick(window,Qt::Key_Space);
            QCoreApplication::processEvents();
            if (window->property("gallery").toBool() ||
                !checkRadio("fleetGalleryToggle","Fleet gallery view",false) ||
                !checkRadio("fleetTableToggle","Fleet table view",true)) {
                qCritical()<<"P4 native Fleet view selection inaccessible after keyboard";
                app.exit(273);return;
            }
            window->setProperty("workspace",2);
            QCoreApplication::processEvents();
            if (!checkRadio("rentalFilterAll","All rentals",true) ||
                !checkRadio("rentalFilterActive","Active rentals",false) ||
                !checkRadio("rentalFilterHistory","History rentals",false)) {
                app.exit(274);return;
            }
            auto *history=find(find,root,"rentalFilterHistory");
            history->forceActiveFocus(Qt::TabFocusReason);
            QTest::keyClick(window,Qt::Key_Space);
            QCoreApplication::processEvents();
            if (rentalModel.statusFilter()!="History" ||
                !checkRadio("rentalFilterAll","All rentals",false) ||
                !checkRadio("rentalFilterHistory","History rentals",true)) {
                qCritical()<<"P4 History accessibility state stale after keyboard";
                app.exit(275);return;
            }
            auto *active=find(find,root,"rentalFilterActive");
            active->forceActiveFocus(Qt::TabFocusReason);
            QTest::keyClick(window,Qt::Key_Space);
            QCoreApplication::processEvents();
            if (rentalModel.statusFilter()!="Active" ||
                !checkRadio("rentalFilterActive","Active rentals",true) ||
                !checkRadio("rentalFilterHistory","History rentals",false)) {
                qCritical()<<"P4 Active accessibility state stale after keyboard";
                app.exit(276);return;
            }
            if (!checkRadio("workspaceNavRentals","Rentals workspace",true) ||
                !checkRadio("workspaceNavFleet","Fleet workspace",false)) {
                qCritical()<<"P4 Rentals workspace accessible state stale";
                app.exit(281);return;
            }
            // Rental row exposes status, due status, value and current selection
            // as spoken metadata; no fictional customer contact is leaked.
            auto *row=find(find,root,"rentalRow");
            auto *rowInterface=row ? QAccessible::queryAccessibleInterface(row) : nullptr;
            if (!rowInterface || !rowInterface->isValid()) {
                qCritical()<<"P4 rental row missing from accessible tree";
                app.exit(282);return;
            }
            const auto rowName=[&] { return rowInterface->text(QAccessible::Name); };
            const QString id=row->property("rentalId").toString();
            const QString due=row->property("dueState").toString();
            const auto total=row->property("total").toDouble();
            const QString value=QStringLiteral("total R %1").arg(total,0,'f',2);
            if (id.isEmpty() || due.isEmpty() ||
                !rowName().contains(QStringLiteral("Rental ")+id) ||
                !rowName().contains(due) || !rowName().contains(value)) {
                qCritical()<<"P4 rental accessible row omitted due/total" <<rowName();
                app.exit(283);return;
            }
            if (!rentalModel.selectById(id)) {
                qCritical()<<"P4 rental accessible selection setup failed"<<id;
                app.exit(284);return;
            }
            QCoreApplication::processEvents();
            if (!rowName().startsWith(QStringLiteral("Selected rental ")+id)) {
                qCritical()<<"P4 selected rental not announced in accessible name"<<rowName();
                app.exit(285);return;
            }
            rentalModel.clearSelection();
            QCoreApplication::processEvents();
            if (!rowName().startsWith(QStringLiteral("Rental ")+id)) {
                qCritical()<<"P4 cleared rental still labelled selected"<<rowName();
                app.exit(286);return;
            }
            QByteArray fv,fr,tr;
            if (!readFile(vehicles,&fv) || !readFile(rentals,&fr) ||
                !readFile(disposable.filePath("rentals.txt"),&tr) ||
                fv!=beforeVehicles || fr!=beforeRentals || tr!=beforeRentals) {
                qCritical()<<"P4 accessibility navigation mutated fictional files";
                app.exit(277);return;
            }
            qInfo()<<"P4 native accessibility controls PASS"
                   <<(compact?"1280x720":"1500x860")
                   <<"real roles/names/checked states and immutable fixtures";
            app.exit(0);
        });
    }
    if (parser.isSet("p4-motion-smoke")) {
        auto *window = qobject_cast<QQuickWindow*>(engine.rootObjects().first());
        if (!window) return 260;
        const bool compact = parser.isSet("compact");
        const bool reduce = parser.isSet("p4-reduce-motion");
        window->resize(compact ? 1280 : 1500, compact ? 720 : 860);
        window->setProperty("workspace", 1);
        QTimer::singleShot(1200, &app, [&, window, compact, reduce]{
            const auto find=[](const auto &self, QQuickItem *item,
                               const QString &name) -> QQuickItem* {
                if (!item) return nullptr;
                if (item->objectName() == name && item->isVisible())
                    return item;
                for (auto *child : item->childItems())
                    if (auto *found=self(self, child, name)) return found;
                return nullptr;
            };
            auto *frame=find(find, window->contentItem(), "fleetGalleryFocus");
            auto matches=[&](bool expected) {
                const int duration=expected ? 0 : 90;
                return motion.reducedMotion() == expected &&
                       motion.selectionFadeMs() == duration &&
                       window->property("reducedMotion").toBool() == expected &&
                       window->property("selectionFadeMs").toInt() == duration &&
                       frame && frame->property("selectionFadeMs").toInt() == duration;
            };
            if (!matches(reduce)) {
                qCritical()<<"P4 initial OS-motion injection/binding failed"
                           <<reduce << motion.selectionFadeMs();
                app.exit(261);return;
            }
            // Simulate a later OS preference change (no host Windows settings
            // modification) and prove the native QML view responds live.
            motion.setTestPreference(!reduce);
            QCoreApplication::processEvents();
            if (!matches(!reduce)) {
                qCritical()<<"P4 live reduced-motion preference changed but QML stale";
                app.exit(262);return;
            }
            motion.setTestPreference(reduce);
            QCoreApplication::processEvents();
            if (!matches(reduce)) {
                qCritical()<<"P4 motion restoration failed";
                app.exit(263);return;
            }
            // Focus ring remains immediate and selected-ID updates remain
            // native C++ operations, without a cosmetic animation dependency.
            auto *gallery=find(find,window->contentItem(),"fleetGallery");
            if (!gallery) { app.exit(264);return; }
            gallery->forceActiveFocus(Qt::TabFocusReason);
            QTest::keyClick(window,Qt::Key_Down);
            QCoreApplication::processEvents();
            if (fleet.selectedId().isEmpty() ||
                !frame->property("keyboardFocused").toBool()) {
                qCritical()<<"P4 motion setting affected keyboard selection";
                app.exit(265);return;
            }
            QByteArray vf,rf,temporary;
            if (!readFile(vehicles,&vf) || !readFile(rentals,&rf) ||
                !readFile(disposable.filePath("rentals.txt"),&temporary) ||
                vf!=beforeVehicles || rf!=beforeRentals ||
                temporary!=beforeRentals) {
                qCritical()<<"P4 motion test mutated fictional source/ledger";
                app.exit(266);return;
            }
            const QString size=compact ? "1280x720" : "1500x860";
            const QString mode=reduce ? "reduced" : "ordinary";
            const QImage image=window->grabWindow();
            if (image.isNull() ||
                image.size()!=QSize(compact?1280:1500,compact?720:860) ||
                !image.save("p4-qt-motion-"+mode+"-"+size+".png","PNG")) {
                qCritical()<<"P4 motion screenshot incorrect";
                app.exit(267);return;
            }
            qInfo()<<"P4 motion policy PASS" <<mode<<size
                   <<"duration" <<motion.selectionFadeMs()
                   <<"live change, instant focus, unmodified fixtures";
            app.exit(0);
        });
    }
    if (parser.isSet("dpi-smoke")) {
        auto *window = qobject_cast<QQuickWindow*>(engine.rootObjects().first());
        if (!window) return 30;
        // 1024x660 logical: remains inside a 1920x1080 hosted desktop at 1.5x.
        window->resize(1024, 660);
        QTimer::singleShot(850, &app, [&, window] {
            bool valid = false;
            const double requested = qEnvironmentVariable("QT_SCALE_FACTOR").toDouble(&valid);
            const double actual = window->devicePixelRatio();
            const QImage shot = window->grabWindow();
            const QSize expected(qRound(window->width() * actual),
                                 qRound(window->height() * actual));
            if (!valid || requested < 1.2 || std::abs(actual-requested) > 0.02 ||
                shot.isNull() || std::abs(shot.width() - expected.width()) > 2 ||
                std::abs(shot.height() - expected.height()) > 2) {
                qCritical() << "Synthetic DPI image mismatch; requested" << requested
                            << "actual DPR" << actual << "image" << shot.size()
                            << "expected" << expected;
                app.exit(31); return;
            }
            const QString file = QString("p2-qt-synthetic-%1.png")
                                    .arg(QString::number(requested, 'f', 2));
            if (!shot.save(file, "PNG")) { app.exit(32); return; }
            qInfo() << "P2 synthetic DPI PASS" << requested << actual << shot.size();
            app.exit(0);
        });
    }
    return app.exec();
}
#include "main.moc"
