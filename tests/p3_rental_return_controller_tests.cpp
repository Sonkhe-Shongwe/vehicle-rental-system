#include "src/application/rental_return_controller.h"
#include "src/application/rental_read_service.h"
#include "src/application/rental_list_model.h"
#include "car.h"
#include "rental.h"
#include "rentalsystem.h"

#include <QCoreApplication>
#include <QFile>
#include <QDir>
#include <QTemporaryDir>
#include <cstdlib>
#include <iostream>
#include <memory>

namespace {
void check(bool b, const char *why) {
    if (!b) { std::cerr << "P3-I return controller FAIL: " << why << '\n'; std::exit(1); }
}
QByteArray bytes(const QString &file) {
    QFile f(file);
    check(f.open(QIODevice::ReadOnly), "file must be readable");
    return f.readAll();
}
void book(RentalSystem &system, const QString &rentalId, const QString &vehicleId) {
    const QDate today = QDate::currentDate();
    auto rental = std::make_unique<Rental>(
        rentalId, "Fictional Name", "0000000000", vehicleId,
        today, today.addDays(2), 2, 450, 900);
    check(system.createRental(rental.get()), "create real fictional rental");
    rental.release();
}
}

int main(int argc, char **argv) {
    QCoreApplication app(argc, argv);
    QTemporaryDir dir;
    check(dir.isValid(), "ephemeral test data");
    RentalSystem system(dir.path());
    check(system.addVehicle(new Car("C001","Fictional","Car",450,4)),
          "seed C001");
    check(system.addVehicle(new Car("C002","Fictional","Car",450,4)),
          "seed C002");
    book(system,"R001","C001");
    book(system,"R002","C002");
    const QString fleetFile = dir.filePath("vehicles.txt");
    const QString ledgerFile = dir.filePath("rentals.txt");
    const QByteArray sourceFleet = bytes(fleetFile);
    const QByteArray originalLedger = bytes(ledgerFile);

    RentalReadService read(system);
    RentalListModel model(read);
    int fleetRefreshes = 0, succeeded = 0, rejected = 0;
    int resets=0, countChanges=0;
    RentalReturnController action(system, read, model,
                                  [&]{ ++fleetRefreshes; });
    QObject::connect(&action,&RentalReturnController::returnSucceeded,
                     [&](const QString &id) {
                         ++succeeded;
                         check(id=="R001" || id=="R002", "real ID in success signal");
                     });
    QObject::connect(&action,&RentalReturnController::returnRejected,
                     [&](RentalReturnError){ ++rejected; });
    QObject::connect(&model,&QAbstractItemModel::modelReset,[&]{++resets;});
    QObject::connect(&model,&RentalListModel::countChanged,[&]{++countChanges;});

    check(!action.canReturnSelected() && !action.returnSelected() &&
          fleetRefreshes==0 && resets==0 && rejected==1,
          "no selection cannot return, refresh or write");
    check(bytes(ledgerFile)==originalLedger, "empty selection strictly read-only");

    check(model.selectById(" r001 ") && action.canReturnSelected(),
          "selected active real ID eligible");
    const QByteArray beforeInvalid=bytes(ledgerFile);
    RentalReturnService impossibleDate(system, read, []{return QDate();});
    check(impossibleDate.returnById("R001").error==RentalReturnError::InvalidReturnDate &&
          bytes(ledgerFile)==beforeInvalid && action.canReturnSelected(),
          "invalid injected date rejected without domain write");
    RentalReturnService futureDate(system, read,
                                   []{return QDate::currentDate().addDays(1);});
    check(futureDate.returnById("R001").error==RentalReturnError::InvalidReturnDate &&
          bytes(ledgerFile)==beforeInvalid, "future return rejected");

    // Reject persistent write failures: rename the real ledger to a backup,
    // block its QSaveFile target with a directory, then restore the original.
    check(QFile::rename(ledgerFile,dir.filePath("rentals-backup.txt")),
          "prepare forced commit failure without losing bytes");
    check(QDir().mkdir(ledgerFile), "block ledger commit path");
    check(!action.returnSelected() && rejected==2 &&
          fleetRefreshes==0 && resets==0 && succeeded==0 &&
          action.lastReturnMessage().contains("not saved") &&
          system.findRentalById("R001") &&
          !system.findRentalById("R001")->getIsReturned() &&
          system.findVehicleById("C001")->getIsRented(),
          "persistence failure rolls back domain and never refreshes models");
    check(QDir().rmdir(ledgerFile) &&
          QFile::rename(dir.filePath("rentals-backup.txt"),ledgerFile) &&
          bytes(ledgerFile)==beforeInvalid, "restore original ledger exactly");
    check(model.selectedRentalId()=="R001" && action.canReturnSelected(),
          "rejected return keeps selected active rental");

    model.setStatusFilter("Active");
    check(action.canReturnSelected(), "active filter retains selected ID");
    const int preSuccessCount=model.count();
    check(action.returnSelected() && succeeded==1 && rejected==2 &&
          fleetRefreshes==1 && resets==2 &&
          model.count()==preSuccessCount-1 &&
          model.selectedRentalId().isEmpty() && !action.canReturnSelected() &&
          !system.findVehicleById("C001")->getIsRented() &&
          bytes(ledgerFile)!=originalLedger &&
          bytes(fleetFile)==sourceFleet, "successful commit updates both snapshots only after write");
    model.setStatusFilter("History");
    check(model.count()==1 && model.selectById("r001") &&
          !action.canReturnSelected() && !action.returnSelected() &&
          rejected==3 && fleetRefreshes==1 && succeeded==1,
          "returned history cannot return twice or refresh on rejection");
    check(action.lastReturnMessage().contains("Only active"),"typed rejection status");

    model.setStatusFilter("All");
    check(model.selectById("R002") && action.canReturnSelected(),
          "second active contract remains eligible");
    check(action.returnSelected() && succeeded==2 && fleetRefreshes==2 &&
          model.selectedRentalId()=="R002" &&
          !action.canReturnSelected() &&
          read.recordById("R002")->status==RentalRecordStatus::Returned,
          "All filter preserves visible selected ID but disables returning again");
    check(bytes(fleetFile)==sourceFleet,"return only changes authoritative rental ledger");
    check(countChanges>=1 && resets>=2, "Qt native model signals observed");

    const QByteArray finalLedger=bytes(ledgerFile);
    model.refresh();
    check(bytes(ledgerFile)==finalLedger && bytes(fleetFile)==sourceFleet,
          "model-only refresh never writes");
    RentalSystem reopened(dir.path());
    check(reopened.findRentalById("R001")->getIsReturned() &&
          reopened.findRentalById("R002")->getIsReturned() &&
          !reopened.findVehicleById("C001")->getIsRented() &&
          !reopened.findVehicleById("C002")->getIsRented(),
          "two committed returns and availability reconstruct on restart");

    std::cout << "P3-I return action persisted/rollback/selection integration PASS\n";
    return 0;
}
