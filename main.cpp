#include <QApplication>
#include <QTimer>
#include "mainwindow.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    MainWindow window;
    window.showMaximized();
    if (app.arguments().contains("--portfolio-screenshot")) {
        QTimer::singleShot(700, &window, [&window, &app]() {
            const bool saved = window.grab().save("portfolio-qt-review.png", "PNG");
            app.exit(saved ? 0 : 2);
        });
    }

    return app.exec();
}
