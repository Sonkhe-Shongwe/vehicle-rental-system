#pragma once
// P7-N: fixed-fictional, opt-in Qt Quick Fleet read surface.
// Never linked to the ordinary Rental Studio executable or authorized for PII.
#include <QObject>
#include <QVariantList>
#include <QVariantMap>
#include <QList>
#include <functional>
#include <optional>
#include <utility>
#include "src/application/fleet_read_service.h"

namespace p7fiction {
class FictionalFleetSnapshot final : public QObject {
    Q_OBJECT
    Q_PROPERTY(bool snapshotAvailable READ snapshotAvailable NOTIFY snapshotAvailabilityChanged)
    Q_PROPERTY(int totalCount READ totalCount NOTIFY snapshotChanged)
    Q_PROPERTY(int availableCount READ availableCount NOTIFY snapshotChanged)
    Q_PROPERTY(QVariantList vehicles READ vehicles NOTIFY snapshotChanged)
public:
    using Provider=std::function<std::optional<QList<FleetVehicleSummary>>()>;
    explicit FictionalFleetSnapshot(Provider provider, QObject *parent=nullptr)
        : QObject(parent), m_provider(std::move(provider)) {refresh();}
    bool snapshotAvailable() const {return m_available;}
    int totalCount() const {return m_rows.size();}
    int availableCount() const {
        int count=0;
        for(const auto &r:m_rows)if(r.available)++count;
        return count;
    }
    QVariantList vehicles() const {
        QVariantList result;
        for(const auto &r:m_rows) {
            QVariantMap item;
            item.insert("id",r.id);
            item.insert("displayName",r.displayName());
            item.insert("type",r.type);
            item.insert("details",r.details);
            item.insert("dailyRate",r.legacyDailyRate);
            item.insert("available",r.available);
            result.append(item);
        }
        return result;
    }
    Q_INVOKABLE void refresh() {
        auto rows=m_provider?m_provider():std::nullopt;
        if(!rows) {
            // Preserve the last verified snapshot internally. UI hides all
            // potentially stale counts until the operator explicitly retries.
            if(m_available) {
                m_available=false;
                emit snapshotAvailabilityChanged();
                emit viewChanged();
            }
            return;
        }
        m_rows=std::move(*rows);
        if(!m_available) {
            m_available=true;
            emit snapshotAvailabilityChanged();
        }
        emit snapshotChanged();
    }
signals:
    void snapshotChanged();
    void snapshotAvailabilityChanged();
private:
    Provider m_provider;
    bool m_available=false;
    QList<FleetVehicleSummary> m_rows;
};
} // namespace p7fiction
