#include "src/application/rental_list_model.h"
#include "src/application/rental_read_service.h"
#include "car.h"
#include "motorcycle.h"
#include "rental.h"
#include "rentalsystem.h"

#include <QAbstractItemModel>
#include <QCoreApplication>
#include <QDate>
#include <QFile>
#include <QObject>
#include <QTemporaryDir>
#include <QVariant>
#include <cstdlib>
#include <iostream>
#include <memory>

namespace {
void check(bool value, const char *message) {
    if (!value) {
        std::cerr << "P3 Rental list model FAIL: " << message << '\n';
        std::exit(EXIT_FAILURE);
    }
}
QByteArray readBytes(const QString &path) {
    QFile file(path);
    check(file.open(QIODevice::ReadOnly), "fixture must be readable");
    return file.readAll();
}
void book(RentalSystem &system, const QString &id,
          const QString &vehicleId, int days, double rate) {
    const QDate today = QDate::currentDate();
    auto rental = std::make_unique<Rental>(
        id, "Fictional Customer", "0000000000", vehicleId,
        today, today.addDays(days), days, rate, rate * days);
    check(system.createRental(rental.get()), "persist fictional rental");
    rental.release();
}
}

int main(int argc, char **argv) {
    QCoreApplication app(argc, argv);
    QTemporaryDir disposable;
    check(disposable.isValid(), "isolated temporary rental ledger");
    const QDate today = QDate::currentDate();
    check(today.isValid(), "date is valid");
    const QString vehiclesPath = disposable.filePath("vehicles.txt");
    const QString rentalsPath = disposable.filePath("rentals.txt");

    {
        RentalSystem system(disposable.path());
        RentalReadService service(system, [today] { return today.addDays(2); });
        RentalListModel model(service);

        int resets = 0;
        int countSignals = 0;
        int selectionSignals = 0;
        QObject::connect(&model, &QAbstractItemModel::modelReset,
                         [&] { ++resets; });
        QObject::connect(&model, &RentalListModel::countChanged,
                         [&] { ++countSignals; });
        QObject::connect(&model, &RentalListModel::selectionChanged,
                         [&] { ++selectionSignals; });

        check(model.count() == 0 && model.rowCount() == 0 &&
              model.rowCount(model.index(0, 0)) == 0 &&
              model.selectedRow() == -1 && model.selectedRentalId().isEmpty(),
              "fresh model is empty and never has an implicit selection");
        check(!model.selectById("R001"), "cannot select an unknown rental");
        const auto roles = model.roleNames();
        check(roles.value(RentalListModel::RentalIdRole) == "rentalId" &&
              roles.value(RentalListModel::StatusRole) == "status" &&
              roles.value(RentalListModel::DueStateRole) == "dueState" &&
              roles.value(RentalListModel::TotalRole) == "total",
              "typed semantic Qt model roles exist");
        for (const auto &roleName : roles) {
            const QByteArray lower = roleName.toLower();
            check(!lower.contains("customer") && !lower.contains("phone"),
                  "general-purpose Qt roles exclude personal contact data");
        }

        check(system.addVehicle(new Car("C001", "Toyota", "Corolla", 450, 4)),
              "add fictional Corolla");
        check(system.addVehicle(new Car("C002", "Ford", "Ranger", 700, 4)),
              "add fictional Ranger");
        check(system.addVehicle(new Motorcycle("M001", "Honda", "CB500F", 280, 471)),
              "add fictional Honda");
        book(system, "R001", "C001", 3, 450);
        book(system, "R002", "C002", 1, 700);
        book(system, "R003", "M001", 2, 280);

        check(model.count() == 0 && resets == 0,
              "domain changes are not presented until explicit refresh");
        const QByteArray fleetBefore = readBytes(vehiclesPath);
        const QByteArray rentalsBefore = readBytes(rentalsPath);
        model.refresh();
        check(model.rowCount() == 3 && model.count() == 3 &&
              resets == 1 && countSignals == 1 && selectionSignals == 0,
              "first explicit refresh resets model and notifies count once");
        check(model.rowCount(model.index(0, 0)) == 0,
              "Qt list model has no child rows");

        const QModelIndex first = model.index(0, 0);
        const QModelIndex second = model.index(1, 0);
        const QModelIndex third = model.index(2, 0);
        check(model.data(first, RentalListModel::RentalIdRole).toString() == "R001" &&
              model.data(first, RentalListModel::VehicleIdRole).toString() == "C001" &&
              model.data(first, RentalListModel::DaysRole).toInt() == 3 &&
              model.data(first, RentalListModel::DailyRateRole).toDouble() == 450.0 &&
              model.data(first, RentalListModel::TotalRole).toDouble() == 1350.0 &&
              model.data(first, RentalListModel::StartDateRole).toDate() == today &&
              model.data(first, RentalListModel::ExpectedReturnDateRole).toDate()
                  == today.addDays(3),
              "correct authoritative ID/date/rate/total roles");
        check(model.data(first, RentalListModel::StatusRole).toString() == "Active" &&
              model.data(first, RentalListModel::DueStateRole).toString() == "NotDue" &&
              model.data(second, RentalListModel::DueStateRole).toString() == "Overdue" &&
              model.data(third, RentalListModel::DueStateRole).toString() == "DueToday",
              "C++ determines lifecycle and injected-clock due states");
        check(!model.data(QModelIndex(), RentalListModel::StatusRole).isValid() &&
              !model.data(first, Qt::UserRole + 999).isValid() &&
              !(model.flags(first) & Qt::ItemIsEditable),
              "invalid role/index and editable item state are not exposed");
        check(readBytes(vehiclesPath) == fleetBefore &&
              readBytes(rentalsPath) == rentalsBefore,
              "read model does not modify stored fleet or rental records");

        check(model.selectById("  r003  ") &&
              model.selectedRentalId() == "R003" &&
              model.selectedRow() == 2 && selectionSignals == 1,
              "stable trimmed/case-insensitive rental selection");
        check(model.selectById("R003") && selectionSignals == 1,
              "reselecting same rental does not emit a duplicate signal");
        check(!model.selectById("R999") && !model.selectById(" ") &&
              model.selectedRentalId() == "R003",
              "unavailable ID does not discard existing selection");
        check(system.completeRental("R002", today),
              "return an independently persisted rental");
        check(model.data(second, RentalListModel::StatusRole).toString() == "Active",
              "model does not optimistically apply domain change");
        model.refresh();
        check(model.data(model.index(1, 0), RentalListModel::StatusRole).toString()
                  == "Returned" &&
              model.data(model.index(1, 0), RentalListModel::DueStateRole).toString()
                  == "NotApplicable" &&
              model.selectedRentalId() == "R003" &&
              model.selectedRow() == 2 && selectionSignals == 1,
              "refresh reflects returned status without changing selected rental");

        check(system.archiveRental("R002"), "archive returned contract");
        model.refresh();
        check(model.data(model.index(1, 0), RentalListModel::StatusRole).toString()
                  == "Archived" &&
              model.selectedRentalId() == "R003",
              "archived status reads from domain and preserves selected ID");

        check(system.deleteArchivedRental("R002"), "remove archived contract");
        model.refresh();
        check(model.count() == 2 &&
              model.selectedRentalId() == "R003" &&
              model.selectedRow() == 1 &&
              selectionSignals == 2,
              "selection follows stable rental ID after prior row disappears");
        check(model.data(model.index(1, 0), RentalListModel::RentalIdRole)
                  .toString() == "R003",
              "selected row now points to the correct rental, not stale position");

        check(model.selectById("R001") && model.selectedRow() == 0,
              "select available active contract");
        check(system.completeRental("R001", today), "complete selected contract");
        model.refresh();
        check(model.selectedRentalId() == "R001" &&
              model.data(model.index(0, 0), RentalListModel::StatusRole)
                  .toString() == "Returned" &&
              model.data(model.index(0, 0), RentalListModel::ActualReturnDateRole)
                  .toDate() == today,
              "selected record remains canonical after return");
        check(system.removeVehicle("C001"), "remove returned vehicle");
        const QByteArray beforeHistoryRead = readBytes(rentalsPath);
        model.refresh();
        check(model.data(model.index(0, 0), RentalListModel::VehicleIdRole)
                  .toString() == "C001" &&
              readBytes(rentalsPath) == beforeHistoryRead,
              "historical rental persists without the original fleet vehicle");

        check(system.completeRental("R003", today), "return last active rental");
        check(system.archiveRental("R003"), "archive last returned rental");
        model.refresh();
        check(model.data(model.index(1, 0), RentalListModel::StatusRole)
                  .toString() == "Archived",
              "archive change follows explicit refresh");
        check(model.selectById("R003"), "select contract that is about to be deleted");
        const int beforeMissing = selectionSignals;
        check(system.deleteArchivedRental("R003"), "delete archived selected contract");
        model.refresh();
        check(model.count() == 1 &&
              model.selectedRentalId().isEmpty() &&
              model.selectedRow() == -1 &&
              selectionSignals == beforeMissing + 1,
              "missing selected ID clears exactly once on explicit refresh");

        const int afterClear = selectionSignals;
        model.clearSelection();
        check(selectionSignals == afterClear,
              "clearSelection is idempotent when selection is absent");
        check(model.selectById("R001"), "reselect remaining returned rental");
        model.clearSelection();
        check(model.selectedRow() == -1 && model.selectedRentalId().isEmpty(),
              "explicit close/deselect clears selection without domain mutation");
        const QByteArray lastFleet = readBytes(vehiclesPath);
        const QByteArray lastRental = readBytes(rentalsPath);
        model.refresh();
        check(readBytes(vehiclesPath) == lastFleet &&
              readBytes(rentalsPath) == lastRental,
              "final refresh cannot write any operational data");
    }

    {
        RentalSystem reopened(disposable.path());
        RentalReadService service(reopened);
        RentalListModel model(service);
        check(model.count() == 1 && model.rowCount() == 1 &&
              model.data(model.index(0, 0), RentalListModel::RentalIdRole)
                  .toString() == "R001" &&
              model.data(model.index(0, 0), RentalListModel::StatusRole)
                  .toString() == "Returned" &&
              model.data(model.index(0, 0), RentalListModel::DueStateRole)
                  .toString() == "NotApplicable" &&
              model.selectedRentalId().isEmpty(),
              "real restart reconstructs history, no implicit selection");
    }

    std::cout << "P3 Rental Qt list model roles, selection and refresh PASS\n";
    return EXIT_SUCCESS;
}
