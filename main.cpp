#include <QApplication>
#include <QLabel>
#include <QTimer>
#include <QDebug>
#include "mainwindow.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    MainWindow window;
    const bool wideScreenshot = app.arguments().contains("--portfolio-screenshot");
    const bool smallScreenshot = app.arguments().contains("--portfolio-screenshot-small");
    const bool fleetWide = app.arguments().contains("--portfolio-fleet-screenshot");
    const bool fleetSmall = app.arguments().contains("--portfolio-fleet-screenshot-small");
    const bool fleetPreview = fleetWide || fleetSmall;

    if (wideScreenshot || smallScreenshot || fleetPreview) {
        // Use a normal window at an explicit size so a small-screen check
        // cannot silently reproduce the same maximized screenshot.
        window.showNormal();
        window.resize((smallScreenshot || fleetSmall) ? 1280 : 1500,
                      (smallScreenshot || fleetSmall) ? 720 : 860);
        if (fleetPreview)
            QMetaObject::invokeMethod(&window, "showAllVehicles", Qt::DirectConnection);
        QTimer::singleShot(700, &window, [&window, &app, fleetPreview]() {
            QWidget* strip = window.findChild<QWidget*>(
                fleetPreview ? "FleetSummary" : "MetricsStrip");
            QLabel* recentHeading = window.findChild<QLabel*>("TableSectionTitle");
            if (!strip || !recentHeading) {
                qWarning() << "Qt visual test: required dashboard widgets missing";
                app.exit(3);
                return;
            }
            const int stripBottom = strip->mapTo(&window, QPoint(0, strip->height())).y();
            const int headingTop = recentHeading->mapTo(&window, QPoint(0, 0)).y();
            if (headingTop < stripBottom + 3) {
                qWarning() << "Qt visual test: section heading overlaps metrics"
                           << headingTop << stripBottom;
                app.exit(4);
                return;
            }
            if (fleetPreview) {
                QLabel* identity = window.findChild<QLabel*>("FleetAssetName");
                QWidget* inspector = window.findChild<QWidget*>("FleetInspector");
                QLineEdit* search = window.findChild<QLineEdit*>("FleetSearch");
                QComboBox* status = window.findChild<QComboBox*>("FleetStatusFilter");
                QTableWidget* table = window.findChild<QTableWidget*>();
                if (!identity || !inspector || !search || !status || !table ||
                    table->rowCount() != 5 || identity->text().isEmpty() ||
                    identity->text() == "No vehicle selected") {
                    qWarning() << "Fleet smoke test: missing control or incorrect fixture";
                    app.exit(5);
                    return;
                }
                const auto visible = [table]() {
                    int count = 0;
                    for (int row = 0; row < table->rowCount(); ++row)
                        count += !table->isRowHidden(row);
                    return count;
                };
                search->setText("ranger");
                if (visible() != 1 || identity->text() != "Ford Ranger") {
                    qWarning() << "Fleet smoke test: vehicle search or selection failed";
                    app.exit(6);
                    return;
                }
                search->clear();
                status->setCurrentIndex(2); // Rented
                if (visible() != 1 || identity->text() != "Ford Ranger") {
                    qWarning() << "Fleet smoke test: rented filter failed";
                    app.exit(7);
                    return;
                }
                status->setCurrentIndex(1); // Available
                if (visible() != 4) {
                    qWarning() << "Fleet smoke test: available filter failed";
                    app.exit(8);
                    return;
                }
                status->setCurrentIndex(0);
                if (visible() != 5) {
                    qWarning() << "Fleet smoke test: filter reset failed";
                    app.exit(9);
                    return;
                }
                table->selectRow(0); // Restore consistent screenshot fixture
            }
            const bool saved = window.grab().save("portfolio-qt-review.png", "PNG");
            app.exit(saved ? 0 : 2);
        });
    } else {
        window.showMaximized();
    }

    return app.exec();
}
