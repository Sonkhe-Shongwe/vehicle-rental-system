#include "src/application/rental_list_model.h"

#include <QVariant>
#include <utility>

namespace {
QString statusText(RentalRecordStatus status) {
    switch (status) {
    case RentalRecordStatus::Active:   return QStringLiteral("Active");
    case RentalRecordStatus::Returned: return QStringLiteral("Returned");
    case RentalRecordStatus::Archived: return QStringLiteral("Archived");
    }
    return QStringLiteral("Unknown");
}

QString dueStateText(RentalDueState due) {
    switch (due) {
    case RentalDueState::NotApplicable: return QStringLiteral("NotApplicable");
    case RentalDueState::NotDue:        return QStringLiteral("NotDue");
    case RentalDueState::DueToday:      return QStringLiteral("DueToday");
    case RentalDueState::Overdue:       return QStringLiteral("Overdue");
    case RentalDueState::Unknown:       return QStringLiteral("Unknown");
    }
    return QStringLiteral("Unknown");
}
}

RentalListModel::RentalListModel(const RentalReadService &service, QObject *parent)
    : QAbstractListModel(parent), m_service(service),
      m_allItems(service.records()), m_items(m_allItems) {}

int RentalListModel::rowCount(const QModelIndex &parent) const {
    return parent.isValid() ? 0 : m_items.size();
}

QVariant RentalListModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid() || index.model() != this || index.column() != 0 ||
        index.row() < 0 || index.row() >= m_items.size())
        return {};

    const auto &item = m_items.at(index.row());
    switch (role) {
    case RentalIdRole:           return item.rentalId;
    case VehicleIdRole:          return item.vehicleId;
    case StartDateRole:          return item.startDate;
    case ExpectedReturnDateRole: return item.expectedReturnDate;
    case ActualReturnDateRole:   return item.actualReturnDate;
    case DaysRole:               return item.rentalDays;
    case DailyRateRole:          return item.legacyDailyRate;
    case TotalRole:              return item.legacyTotal;
    case StatusRole:             return statusText(item.status);
    case DueStateRole:           return dueStateText(item.dueState);
    default:                     return {};
    }
}

QHash<int, QByteArray> RentalListModel::roleNames() const {
    return {
        {RentalIdRole, "rentalId"},
        {VehicleIdRole, "vehicleId"},
        {StartDateRole, "startDate"},
        {ExpectedReturnDateRole, "expectedReturnDate"},
        {ActualReturnDateRole, "actualReturnDate"},
        {DaysRole, "days"},
        {DailyRateRole, "dailyRate"},
        {TotalRole, "total"},
        {StatusRole, "status"},
        {DueStateRole, "dueState"}
    };
}


QList<RentalRecordSummary> RentalListModel::filtered(
        const QList<RentalRecordSummary> &all) const {
    if (m_statusFilter == QStringLiteral("All"))
        return all;
    QList<RentalRecordSummary> result;
    for (const auto &item : all) {
        const bool active = item.status == RentalRecordStatus::Active;
        if ((m_statusFilter == QStringLiteral("Active") && active) ||
            (m_statusFilter == QStringLiteral("History") && !active))
            result.append(item);
    }
    return result;
}

void RentalListModel::setStatusFilter(const QString &filter) {
    // The C++ model, never QML, determines which lifecycle flags are history.
    if (filter != QStringLiteral("All") &&
        filter != QStringLiteral("Active") &&
        filter != QStringLiteral("History"))
        return;
    if (filter == m_statusFilter)
        return;
    const int oldCount = m_items.size();
    const int oldRow = selectedRow();
    const QString oldId = m_selectedRentalId;
    m_statusFilter = filter;
    QList<RentalRecordSummary> visible = filtered(m_allItems);
    beginResetModel();
    m_items = std::move(visible);
    if (rowForId(oldId) < 0)
        m_selectedRentalId.clear();
    endResetModel();
    emit statusFilterChanged();
    if (m_items.size() != oldCount)
        emit countChanged();
    if (oldId != m_selectedRentalId || oldRow != selectedRow())
        emit selectionChanged();
}

bool RentalListModel::selectVisibleRow(int row) {
    if (row < 0 || row >= m_items.size())
        return false;
    return selectById(m_items.at(row).rentalId);
}

int RentalListModel::rowForId(const QString &id) const {
    const QString normalized = id.trimmed();
    if (normalized.isEmpty())
        return -1;
    for (int row = 0; row < m_items.size(); ++row) {
        if (m_items.at(row).rentalId.compare(normalized, Qt::CaseInsensitive) == 0)
            return row;
    }
    return -1;
}

int RentalListModel::selectedRow() const {
    return rowForId(m_selectedRentalId);
}

bool RentalListModel::selectById(const QString &id) {
    const int row = rowForId(id);
    if (row < 0)
        return false; // An unknown or hidden ID never changes current selection.
    const QString canonicalId = m_items.at(row).rentalId;
    if (canonicalId != m_selectedRentalId) {
        m_selectedRentalId = canonicalId;
        emit selectionChanged();
    }
    return true;
}

void RentalListModel::clearSelection() {
    if (m_selectedRentalId.isEmpty())
        return;
    m_selectedRentalId.clear();
    emit selectionChanged();
}

void RentalListModel::refresh() {
    // No signals are emitted by RentalSystem when it changes. A future
    // command controller must invoke refresh() only after domain state is
    // actually committed. Model reset rebinds QML/list views to latest values.
    const int priorCount = m_items.size();
    const int priorRow = selectedRow();
    const QString priorId = m_selectedRentalId;
    QList<RentalRecordSummary> latest = m_service.records();
    QList<RentalRecordSummary> visible = filtered(latest);

    beginResetModel();
    m_allItems = std::move(latest);
    m_items = std::move(visible);
    if (rowForId(priorId) < 0)
        m_selectedRentalId.clear();
    endResetModel();

    if (m_items.size() != priorCount)
        emit countChanged();
    if (priorId != m_selectedRentalId || selectedRow() != priorRow)
        emit selectionChanged();
}
