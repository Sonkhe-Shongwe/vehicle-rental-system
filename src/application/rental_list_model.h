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
    QString selectedRentalId() const { return m_selectedRentalId; }
    int selectedRow() const;

    Q_INVOKABLE void refresh();
    Q_INVOKABLE bool selectById(const QString &rentalId);
    Q_INVOKABLE void clearSelection();

signals:
    void selectionChanged();
    void countChanged();

private:
    int rowForId(const QString &rentalId) const;

    const RentalReadService &m_service;
    QList<RentalRecordSummary> m_items;
    QString m_selectedRentalId;
};

#endif
