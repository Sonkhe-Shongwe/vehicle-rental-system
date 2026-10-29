#include "mainwindow.h"
#include "rentalsystem.h"

#include <QApplication>
#include <QAbstractButton>
#include <QFile>
#include <QLabel>
#include <QLineEdit>
#include <QMessageBox>
#include <QPushButton>
#include <QSpinBox>
#include <QTableWidget>
#include <QTemporaryDir>
#include <QTimer>

#include <iostream>
#include <memory>
#include <stdexcept>

namespace {
void require(bool condition, const QString& description)
{
    if (!condition)
        throw std::runtime_error(description.toStdString());
}

template <typename T>
T* widget(MainWindow& window, const char* name)
{
    T* found = window.findChild<T*>(QString::fromLatin1(name));
    require(found != nullptr, QString("Missing Qt control: %1").arg(name));
    return found;
}

QPushButton* button(MainWindow& window, const QString& label)
{
    for (QPushButton* candidate : window.findChildren<QPushButton*>()) {
        if (candidate->text() == label)
            return candidate;
    }
    throw std::runtime_error(("Missing button: " + label).toStdString());
}

void navigate(MainWindow& window, const char* slot)
{
    require(QMetaObject::invokeMethod(&window, slot, Qt::DirectConnection),
            QString("Qt navigation slot failed: %1").arg(slot));
    QApplication::processEvents();
}

QByteArray contents(const QString& path)
{
    QFile file(path);
    require(file.open(QIODevice::ReadOnly), "Unable to read temporary persisted fixture: " + path);
    return file.readAll();
}
}

int main(int argc, char* argv[])
{
    QApplication application(argc, argv);
    // Never instantiate the production/default-path MainWindow in this test.
    QTemporaryDir isolated;
    if (!isolated.isValid()) {
        std::cerr << "Cannot create disposable rental test directory\n";
        return 1;
    }

    QStringList expectedDialogs;
    QStringList observedDialogs;
    bool unexpectedDialog = false;
    // Modal confirmation and information boxes have nested event loops.
    // Drive exactly the expected dialog titles, not arbitrary "Yes" prompts.
    QTimer dialogDriver;
    QObject::connect(&dialogDriver, &QTimer::timeout, &application, [&]() {
        auto* dialog = qobject_cast<QMessageBox*>(QApplication::activeModalWidget());
        if (!dialog)
            return;
        const QString title = dialog->windowTitle();
        const int next = observedDialogs.size();
        const bool expected = next < expectedDialogs.size() &&
                              title == expectedDialogs.at(next);
        observedDialogs.append(title);
        if (!expected)
            unexpectedDialog = true;
        const auto choice = expected && (dialog->standardButtons() & QMessageBox::Yes)
                                ? QMessageBox::Yes
                                : (dialog->standardButtons() & QMessageBox::Ok)
                                      ? QMessageBox::Ok : QMessageBox::No;
        if (QAbstractButton* press = dialog->button(choice))
            press->click();
        else
            dialog->reject();
    });
    dialogDriver.start(5);

    auto perform = [&](MainWindow& window, const QString& label,
                       const QStringList& dialogs) {
        expectedDialogs = dialogs;
        observedDialogs.clear();
        unexpectedDialog = false;
        button(window, label)->click();
        require(!unexpectedDialog && observedDialogs == expectedDialogs,
                QString("Unexpected dialogs after %1: expected [%2], observed [%3]")
                    .arg(label, expectedDialogs.join(", "), observedDialogs.join(", ")));
    };

    try {
        const QString vehiclesPath = isolated.filePath("vehicles.txt");
        const QString rentalsPath = isolated.filePath("rentals.txt");
        {
            auto window = std::make_unique<MainWindow>(isolated.path());
            window->showNormal();
            window->resize(1280, 720);
            navigate(*window, "showAddPage");

            auto* id = widget<QLineEdit>(*window, "AddVehicleID");
            require(id->text() == "C001", "First generated car ID is C001");
            widget<QLineEdit>(*window, "AddVehicleBrand")->setText("Fictional");
            widget<QLineEdit>(*window, "AddVehicleModel")->setText("Test Hatch");
            widget<QLineEdit>(*window, "AddVehiclePrice")->setText("125.00");
            widget<QLineEdit>(*window, "AddVehicleExtra")->setText("4");
            perform(*window, "Save Vehicle", {"Confirm Add Vehicle", "Vehicle Added"});

            // Add a second vehicle using the existing motorcycle form.
            button(*window, "Motorcycle")->click();
            const QString motorcycleId = id->text();
            require(motorcycleId.startsWith("M"), "Motorcycle receives an M-prefixed identifier");
            widget<QLineEdit>(*window, "AddVehicleBrand")->setText("Fictional");
            widget<QLineEdit>(*window, "AddVehicleModel")->setText("Test Bike");
            widget<QLineEdit>(*window, "AddVehiclePrice")->setText("75.00");
            widget<QLineEdit>(*window, "AddVehicleExtra")->setText("500");
            perform(*window, "Save Vehicle", {"Confirm Add Vehicle", "Vehicle Added"});

            navigate(*window, "showAllVehicles");
            require(window->findChild<QTableWidget*>()->rowCount() == 2,
                    "GUI fleet table reflects both created vehicles");

            navigate(*window, "showRentPage");
            auto* rentalVehicle = widget<QLineEdit>(*window, "RentalVehicleID");
            auto* confirm = button(*window, "Confirm rental");
            rentalVehicle->setText("C001");
            widget<QSpinBox>(*window, "RentalDays")->setValue(2);
            require(!confirm->isEnabled(), "Customer gating prevents incomplete rental");
            require(widget<QLabel>(*window, "QuoteTotal")->text() == "R250.00",
                    "Quote is derived from daily rate and two-day duration");
            QLineEdit* customer = nullptr;
            QLineEdit* phone = nullptr;
            for (QLineEdit* entry : window->findChildren<QLineEdit*>()) {
                if (entry->placeholderText() == "Customer full name") customer = entry;
                if (entry->placeholderText() == "e.g. 082 123 4567") phone = entry;
            }
            require(customer && phone, "Customer input fields exist");
            customer->setText("Fictional Test Customer");
            phone->setText("0000000000");
            require(confirm->isEnabled(), "Completed rental details enable confirmation");
            perform(*window, "Confirm rental", {"Confirm Rental", "Rental Created"});

            // Rental cannot be booked a second time through the UI.
            rentalVehicle->setText("C001");
            customer->setText("Fictional Other Customer");
            phone->setText("0000000000");
            require(!confirm->isEnabled(), "Active rental prevents another confirmation");
            {
                RentalSystem disk(isolated.path());
                require(disk.getActiveRentals().size() == 1,
                        "Exactly one rental was saved");
                require(disk.findVehicleById("C001")->getIsRented(),
                        "Persisted vehicle is unavailable");
                require(disk.findRentalById("R001")->getTotalCost() == 250.00,
                        "Persisted rental total is correct");
            }
        }

        // Reopen a brand new Qt MainWindow against the same disposable data.
        const QByteArray beforeRestartVehicles = contents(vehiclesPath);
        const QByteArray beforeRestartRentals = contents(rentalsPath);
        {
            auto window = std::make_unique<MainWindow>(isolated.path());
            window->showNormal();
            window->resize(1280, 720);
            require(contents(vehiclesPath) == beforeRestartVehicles &&
                    contents(rentalsPath) == beforeRestartRentals,
                    "Reopening the real GUI does not rewrite source files");

            navigate(*window, "showRentalRecordsPage");
            require(window->findChild<QTableWidget*>()->rowCount() == 1,
                    "Saved active contract appears in Rental History");
            widget<QLineEdit>(*window, "RentalRecordID")->setText("R001");
            perform(*window, "Archive returned", {"Archive Error"});
            perform(*window, "Delete archived", {"Delete Error"});

            navigate(*window, "showReturnPage");
            widget<QLineEdit>(*window, "ReturnRentalID")->setText("R001");
            perform(*window, "Complete return", {"Confirm Return", "Return Completed"});
            widget<QLineEdit>(*window, "ReturnRentalID")->setText("R001");
            perform(*window, "Complete return", {"Return Error"});

            navigate(*window, "showRentalRecordsPage");
            widget<QLineEdit>(*window, "RentalRecordID")->setText("R001");
            perform(*window, "Archive returned", {"Confirm Archive", "Record Archived"});
            widget<QLineEdit>(*window, "RentalRecordID")->setText("R001");
            perform(*window, "Delete archived", {"Confirm Permanent Deletion", "Record Deleted"});
        }
        {
            RentalSystem disk(isolated.path());
            require(disk.getVehicles().size() == 2, "Fleet remains after restart");
            require(disk.getActiveRentals().isEmpty(), "Returned occupancy persists");
            require(!disk.findVehicleById("C001")->getIsRented(),
                    "Previously booked vehicle is available");
            require(disk.getRentals().isEmpty(), "Archived deletion persists after restart");
        }
        std::cout << "PASS: real Qt Widgets add, rent, guard, restart, return, "
                     "archive and delete using isolated fictional data\n";
        return 0;
    } catch (const std::exception& error) {
        std::cerr << "Qt lifecycle regression failed: " << error.what() << '\n';
        return 1;
    }
}
