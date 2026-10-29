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
                if (!identity || !inspector || identity->text().isEmpty() ||
                    identity->text() == "No vehicle selected") {
                    qWarning() << "Qt visual test: fleet inspector has no selection";
                    app.exit(5);
                    return;
                }
            }
            const bool saved = window.grab().save("portfolio-qt-review.png", "PNG");
            app.exit(saved ? 0 : 2);
        });
    } else {
        window.showMaximized();
    }

    return app.exec();
}
