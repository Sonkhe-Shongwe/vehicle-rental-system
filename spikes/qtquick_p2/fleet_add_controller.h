#pragma once
#include <QObject>
#include <QString>
#include <functional>
#include "src/application/rental_admin_commands.h"
class RentalSystem;
class FleetAddController final : public QObject {
 Q_OBJECT
 Q_PROPERTY(QString lastMessage READ lastMessage NOTIFY messageChanged)
 Q_PROPERTY(bool canAdd READ canAdd CONSTANT)
public:
 FleetAddController(RentalSystem &system,bool disposable,std::function<void(const QString &)> afterCommit,QObject *parent=nullptr);
 QString lastMessage() const { return m_message; }
 bool canAdd() const { return m_disposable; }
 Q_INVOKABLE bool addVehicle(const QString &kind,const QString &brand,const QString &model,double dailyRate,int extra);
signals:
 void messageChanged();
private:
 FleetWriteService m_writer;
 bool m_disposable=false;
 std::function<void(const QString &)> m_afterCommit;
 QString m_message;
};

// P6: preliminary adapter; gated pending UI integration and CI.
