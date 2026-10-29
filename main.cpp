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

    if (wideScreenshot || smallScreenshot) {
        // Use a normal window at an explicit size so a small-screen check
        // cannot silently reproduce the same maximized screenshot.
        window.showNormal();
        window.resize(smallScreenshot ? 1280 : 1500,
                      smallScreenshot ? 720 : 860);
        QTimer::singleShot(700, &window, [&window, &app]() {
            QWidget* strip = window.findChild<QWidget*>("MetricsStrip");
            QLabel* recentHeading = window.findChild<QLabel*>("TableSectionTitle");
            if (!strip || !recentHeading) {
                qWarning() << "Qt visual test: required dashboard widgets missing";
                app.exit(3);
                return;
            }
            const int stripBottom = strip->mapTo(&window, QPoint(0, strip->height())).y();
            const int headingTop = recentHeading->mapTo(&window, QPoint(0, 0)).y();
            if (headingTop < stripBottom + 3) {
                qWarning() << "Qt visual test: dashboard heading overlaps metrics"
                           << headingTop << stripBottom;
                app.exit(4);
                return;
            }
            const bool saved = window.grab().save("portfolio-qt-review.png", "PNG");
            app.exit(saved ? 0 : 2);
        });
    } else {
        window.showMaximized();
    }

    return app.exec();
}
