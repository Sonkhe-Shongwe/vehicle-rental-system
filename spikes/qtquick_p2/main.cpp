#include <QAbstractListModel>
#include <QCommandLineParser>
#include <QDebug>
#include <QDir>
#include <QFile>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QSortFilterProxyModel>
#include <QTemporaryDir>
#include <QVariant>
#include <cmath>
#include "rentalsystem.h"

// Uses RentalSystem's existing domain objects from a disposable copy of
// committed fictional fixtures. Neither QML nor this prototype can write.
class FleetModel final : public QAbstractListModel {
    Q_OBJECT
public:
    enum Role {
        VehicleId = Qt::UserRole + 1,
        DisplayName, VehicleType, DailyRate, Available, Details
    };
    explicit FleetModel(const RentalSystem &system, QObject *parent = nullptr)
        : QAbstractListModel(parent), m_vehicles(system.getVehicles()) {}
    int rowCount(const QModelIndex &parent = QModelIndex()) const override {
        return parent.isValid() ? 0 : m_vehicles.size();
    }
    QVariant data(const QModelIndex &index, int role) const override {
        if (!index.isValid() || index.row() < 0 || index.row() >= m_vehicles.size())
            return {};
        const Vehicle *v = m_vehicles.at(index.row());
        switch (role) {
        case VehicleId: return v->getId();
        case DisplayName: return v->getBrand() + " " + v->getModel();
        case VehicleType: return v->typeName();
        case DailyRate: return v->getPricePerDay();
        case Available: return !v->getIsRented();
        case Details: return v->extraDetails();
        default: return {};
        }
    }
    QHash<int, QByteArray> roleNames() const override {
        return {{VehicleId,"vehicleId"},{DisplayName,"displayName"},
                {VehicleType,"vehicleType"},{DailyRate,"dailyRate"},
                {Available,"available"},{Details,"details"}};
    }
private:
    const QList<Vehicle*> m_vehicles;
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
        : QObject(parent), m_system(system), m_source(system, this), m_proxy(this) {
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
        emit queryChanged();
    }
    void setStatus(const QString &status) {
        if (status != "All" && status != "Available" && status != "Rented") return;
        if (status == m_status) return;
        m_status = status;
        m_proxy.setStatus(status);
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
        return v ? v->getBrand() + " " + v->getModel() : QString();
    }
    QString selectedType() const {
        const auto *v = selectedVehicle();
        return v ? v->typeName() : QString();
    }
    QString selectedDetails() const {
        const auto *v = selectedVehicle();
        return v ? v->extraDetails() : QString();
    }
    QString selectedRate() const {
        const auto *v = selectedVehicle();
        return v ? QString::number(v->getPricePerDay(), 'f', 2) : QString();
    }
    bool selectedAvailable() const {
        const auto *v = selectedVehicle();
        return v && !v->getIsRented();
    }
    int totalCount() const { return m_source.rowCount(); }
    int availableCount() const {
        int count = 0;
        for (auto *v : m_system.getVehicles()) count += !v->getIsRented();
        return count;
    }
    Q_INVOKABLE void selectById(const QString &id) {
        const auto *vehicle = m_system.findVehicleById(id);
        if (!vehicle) return;
        if (m_selectedId == vehicle->getId()) return;
        m_selectedId = vehicle->getId();
        emit selectionChanged();
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
    const Vehicle *selectedVehicle() const {
        return m_selectedId.isEmpty()
            ? nullptr : m_system.findVehicleById(m_selectedId);
    }
    RentalSystem &m_system;
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
    parser.process(app);

    // No source-adjacent storage or external/customer-data CLI argument.
    const QDir source(QStringLiteral(RENTAL_STUDIO_DEMO_DIR));
    QTemporaryDir disposable;
    if (!disposable.isValid()) {
        qCritical() << "Cannot create isolated fixture directory";
        return 2;
    }
    QByteArray beforeVehicles, beforeRentals;
    const QString vehicles = source.filePath("vehicles.txt");
    const QString rentals = source.filePath("rentals.txt");
    if (!readFile(vehicles, &beforeVehicles) ||
        !readFile(rentals, &beforeRentals) ||
        !QFile::copy(vehicles, disposable.filePath("vehicles.txt")) ||
        !QFile::copy(rentals, disposable.filePath("rentals.txt"))) {
        qCritical() << "Cannot load committed fictional demo fixtures";
        return 3;
    }

    RentalSystem system(disposable.path());
    FleetController fleet(system);
    if (parser.isSet("self-test")) {
        bool ok = fleet.totalCount() == 5 && fleet.availableCount() == 4
               && qFuzzyCompare(1.0 + system.findVehicleById("C001")->getPricePerDay(), 451.0);
        fleet.setQuery("Honda");
        ok = ok && static_cast<FleetProxy*>(fleet.visibleModel())->rowCount() == 1;
        fleet.selectById("M001");
        ok = ok && fleet.selectedId() == "M001";
        fleet.setQuery("");
        fleet.setStatus("Rented");
        ok = ok && static_cast<FleetProxy*>(fleet.visibleModel())->rowCount() == 1;
        fleet.setSortBy("Rate");
        fleet.setStatus("All");
        ok = ok && static_cast<FleetProxy*>(fleet.visibleModel())->rowCount() == 5
                && fleet.selectedId() == "M001";
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
    engine.loadFromModule("RentalStudioSpike", "Main");
    if (engine.rootObjects().isEmpty()) {
        qCritical() << "Qt Quick did not load the P2 window";
        return 5;
    }
    return app.exec();
}
#include "main.moc"
