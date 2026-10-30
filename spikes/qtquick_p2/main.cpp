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
        : QAbstractListModel(parent), m_vehicles(readService.vehicles()) {}
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
    const QList<FleetVehicleSummary> m_vehicles;
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
    Q_PROPERTY(int totalCount READ totalCount CONSTANT)
    Q_PROPERTY(int availableCount READ availableCount CONSTANT)
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
    QQuickStyle::setStyle("Basic");
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("fleet", &fleet);
    engine.rootContext()->setContextProperty("rentalsModel", &rentalModel);
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
                rentalModel.count() != 2 || list->property("count").toInt() != 2) {
                qCritical() << "P3-F commit/refresh boundary failed"
                            << committed.ok() << rentalModel.count();
                app.exit(86); return;
            }

            rentalModel.refresh();  // Only after the successful C++ commit.
            QTest::qWait(180);
            QCoreApplication::processEvents();
            if (rentalModel.count() != 3 || list->property("count").toInt() != 3 ||
                rentalModel.selectedRentalId() != "R001" ||
                !findRentalRow(findRentalRow, list, "R003")) {
                qCritical() << "P3-F QML did not refresh after persisted confirmation";
                app.exit(87); return;
            }

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
            qInfo() << "P3-F REAL QML Rentals PASS:" << sizeLabel
                    << "keyboard selection, typed statuses, committed booking,"
                    << "explicit refresh, archived history, source-fixture protection";
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
