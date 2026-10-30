#include "src/application/rental_archive_controller.h"
#include "src/application/rental_list_model.h"
#include "src/application/rental_read_service.h"
#include "rentalsystem.h"
#include "car.h"
#include "rental.h"
#include <QCoreApplication>
#include <QTemporaryDir>
#include <QFile>
#include <QDir>
#include <cstdlib>
#include <iostream>
#include <memory>
namespace {
void check(bool x, const char *why) {
    if (!x) { std::cerr<<"P3 archive FAIL: "<<why<<'\n'; std::exit(1); }
}
QByteArray read(const QString &path) {
    QFile f(path);check(f.open(QIODevice::ReadOnly),"read fixture");return f.readAll();
}
}
int main(int argc,char **argv) {
    QCoreApplication app(argc,argv);
    QTemporaryDir tmp;check(tmp.isValid(),"temporary fixtures");
    RentalSystem system(tmp.path());
    check(system.addVehicle(new Car("C001","Fictional","Car",450,4)),"add car");
    const QDate today=QDate::currentDate();
    auto rental=std::make_unique<Rental>("R001","Fictional Person","0000000000",
                                        "C001",today,today.addDays(2),2,450,900);
    check(system.createRental(rental.get()),"persist rental");
    rental.release();
    const QString fleet=tmp.filePath("vehicles.txt");
    const QString ledger=tmp.filePath("rentals.txt");
    const QByteArray sourceFleet=read(fleet);
    RentalReadService reads(system);
    RentalListModel model(reads);
    int reset=0,passed=0,rejected=0;
    QObject::connect(&model,&QAbstractItemModel::modelReset,[&]{++reset;});
    RentalArchiveController action(system,reads,model);
    QObject::connect(&action,&RentalArchiveController::archiveSucceeded,
                     [&](const QString &id){++passed;check(id=="R001","receipt ID");});
    QObject::connect(&action,&RentalArchiveController::archiveRejected,
                     [&](RentalArchiveError){++rejected;});

    check(!action.archiveSelected() && rejected==1 && reset==0,
          "empty selection rejected without refresh");
    check(model.selectById("R001") && !action.canArchiveSelected() &&
          !action.archiveSelected() && rejected==2,"active cannot archive");
    check(system.completeRental("R001",today),"committed returned rental");
    model.refresh();
    check(action.canArchiveSelected() && model.selectedRentalId()=="R001",
          "returned record eligible with stable selection");
    const QByteArray returnedLedger=read(ledger);
    // Protect initial ledger by using a directory as the QSaveFile target.
    check(QFile::rename(ledger,tmp.filePath("rentals-backup.txt")),"backup ledger");
    check(QDir().mkdir(ledger),"block ledger writer");
    const int before=reset;
    check(!action.archiveSelected() && rejected==3 && passed==0 &&
          reset==before && action.canArchiveSelected() &&
          !system.findRentalById("R001")->getIsArchived(),
          "persistence failure rolls back without false refresh/success");
    check(QDir().rmdir(ledger) &&
          QFile::rename(tmp.filePath("rentals-backup.txt"),ledger) &&
          read(ledger)==returnedLedger,"restore file bytes");
    model.setStatusFilter("History");
    check(model.selectedRentalId()=="R001" && model.count()==1,
          "History selected returned record");
    check(action.archiveSelected() && passed==1 &&
          !action.canArchiveSelected() &&
          model.selectedRentalId()=="R001" &&
          model.data(model.index(0,0),RentalListModel::StatusRole)=="Archived" &&
          read(ledger)!=returnedLedger,
          "successful archive persisted and refreshed history");
    check(!action.archiveSelected() && rejected==4,
          "repeat archive blocked without another commit");
    model.setStatusFilter("Active");
    check(model.count()==0 && model.selectedRentalId().isEmpty(),
          "Archived never exposed as Active");
    const auto after=read(ledger);
    model.setStatusFilter("All");
    model.refresh();
    check(read(ledger)==after && read(fleet)==sourceFleet,
          "read models do not write original fleet or archive ledger");
    RentalSystem reopened(tmp.path());
    check(reopened.findRentalById("R001")->getIsArchived() &&
          reopened.findRentalById("R001")->getIsReturned() &&
          !reopened.findVehicleById("C001")->getIsRented(),
          "archived record persists across restart and occupancy remains free");
    std::cout<<"P3 archive C++ commit, rollback, history and restart PASS\n";
    return 0;
}
