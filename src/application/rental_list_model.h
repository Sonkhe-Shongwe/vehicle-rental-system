#ifndef RENTAL_STUDIO_RENTAL_LIST_MODEL_H
#define RENTAL_STUDIO_RENTAL_LIST_MODEL_H

#include "src/application/rental_read_service.h"

#include <QAbstractListModel>
#include <QList>
#include <QString>

// Native Qt read-only model. The service and its owning RentalSystem must
// outlive this adapter. No Rental* or customer PII is exposed through roles.
// The caller explicitly refreshes after an authoritative domain transaction;
// selection is stored by immutable-in-session rental ID, never an old row.
class RentalListModel final : public QAbstractListModel {
    Q_OBJECT
    Q_PROPERTY(QString selectedRentalId READ selectedRentalId NOTIFY selectionChanged)
    Q_PROPERTY(int selectedRow READ selectedRow NOTIFY selectionChanged)
    Q_PROPERTY(int count READ count NOTIFY countChanged)
    Q_PROPERTY(QString statusFilter READ statusFilter WRITE setStatusFilter NOTIFY statusFilterChanged)
    // Derived from the complete C++ snapshot, never the filtered Rentals view.
    Q_PROPERTY(int activeCount READ activeCount NOTIFY metricsChanged)
    Q_PROPERTY(int historyCount READ historyCount NOTIFY metricsChanged)
    Q_PROPERTY(int overdueCount READ overdueCount NOTIFY metricsChanged)
    Q_PROPERTY(int dueTodayCount READ dueTodayCount NOTIFY metricsChanged)
    Q_PROPERTY(double activeBookedValue READ activeBookedValue NOTIFY metricsChanged)
    Q_PROPERTY(QString oldestOverdueRentalId READ oldestOverdueRentalId NOTIFY metricsChanged)
public:
    enum Role {
        RentalIdRole = Qt::UserRole + 1,
        VehicleIdRole,
        StartDateRole,
        ExpectedReturnDateRole,
        ActualReturnDateRole,
        DaysRole,
        DailyRateRole,
        TotalRole,
        StatusRole,
        DueStateRole
    };

    explicit RentalListModel(const RentalReadService &service,
                             QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    int count() const { return m_items.size(); }
    int activeCount() const;
    int historyCount() const;
    int overdueCount() const;
    int dueTodayCount() const;
    double activeBookedValue() const;
    QString oldestOverdueRentalId() const;
    QString statusFilter() const { return m_statusFilter; }
    void setStatusFilter(const QString &filter);
    QString selectedRentalId() const { return m_selectedRentalId; }
    int selectedRow() const;

    Q_INVOKABLE void refresh();
    Q_INVOKABLE bool selectById(const QString &rentalId);
    Q_INVOKABLE bool selectVisibleRow(int row);
    // Navigate the oldest overdue active contract from the complete C++ snapshot.
    // Read/selection only: no booking, return, archive, or disk write.
    Q_INVOKABLE bool selectOldestOverdue();
    Q_INVOKABLE void clearSelection();

signals:
    void selectionChanged();
    void countChanged();
    void statusFilterChanged();
    void metricsChanged();

private:
    int rowForId(const QString &rentalId) const;
    QList<RentalRecordSummary> filtered(const QList<RentalRecordSummary> &all) const;

    const RentalReadService &m_service;
    QList<RentalRecordSummary> m_allItems;
    QList<RentalRecordSummary> m_items;
    QString m_statusFilter = QStringLiteral("All");
    QString m_selectedRentalId;
};

#endif
