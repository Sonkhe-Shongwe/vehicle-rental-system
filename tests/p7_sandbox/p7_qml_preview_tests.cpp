// P7-I: real Qt Quick controls exercising typed normalized repository via
// QObject controller. Built ONLY by explicitly-enabled fictional P7 CTests.
// No arbitrary file path or real PII input. Never a production executable.
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QQuickWindow>
#include <QQuickItem>
#include <QTest>
#include <QTimer>
#include <QDebug>
#include <QSignalSpy>
#include "src/application/p7_sandbox/sqlite_read_projection.h"
#include "src/application/rental_list_model.h"
#include "src/application/p7_sandbox/repository_preview_controller.h"

static QQuickItem *find(QQuickItem *item, const QString &name) {
    if(!item)return nullptr;
    if(item->objectName()==name)return item;
    for(auto *child:item->childItems())
        if(auto *value=find(child,name))return value;
    return nullptr;
}
int main(int argc,char **argv) {
    QGuiApplication app(argc,argv);
    if(app.arguments().size()!=2 ||
       (app.arguments()[1]!="journey" && app.arguments()[1]!="rollback"
        && app.arguments()[1]!="read_model")) {
        qCritical()<<"Only fixed fictional P7-I validation cases accepted";return 2;
    }
    p7fiction::PreviewController preview;
    if(!preview.ready() || !preview.committedStateConsistent())return 3;
    RentalListModel readModel(
        [&preview]() -> std::optional<QList<RentalRecordSummary>> {
            const auto *repo=preview.testOnlyReadRepository();
            if(!repo)return {};
            return p7fiction::ReadProjection(*repo).rentals(QDate(2026,11,2));
        });
    QObject::connect(&preview,&p7fiction::PreviewController::committed,
                     &readModel,&RentalListModel::refresh);
    if(readModel.count()!=0||readModel.activeCount()!=0||
       readModel.historyCount()!=0)return 11;
    QSignalSpy metrics(&readModel,&RentalListModel::metricsChanged);
    QQuickStyle::setStyle("Basic");
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("previewController",&preview);
    engine.rootContext()->setContextProperty("sharedRentals",&readModel);
    engine.load(QUrl("qrc:/p7/p7_fictional_preview.qml"));
    auto *window=engine.rootObjects().isEmpty()?nullptr:
        qobject_cast<QQuickWindow*>(engine.rootObjects().first());
    if(!window){qCritical()<<"Qt Quick preview failed to load";return 4;}
    window->resize(880,640);
    QTimer::singleShot(800,&app,[&] {
        auto *root=window->contentItem();
        auto *quote=find(root,"p7QuoteLabel");
        auto *receipt=find(root,"p7ReceiptLabel");
        auto *state=find(root,"p7StateLabel");
        auto *shared=find(root,"p7SharedMetrics");
        if(!quote||!receipt||!state||!shared ||
           !shared->property("text").toString().contains("Active rentals: 0")){
            app.exit(5);return;
        }
        const auto click=[&](const QString &name)->bool {
            auto *control=find(root,name);
            if(!control || !control->isVisible() || !control->isEnabled() ||
               control->width()<10 || control->height()<10)return false;
            const auto point=control->mapToScene(
                QPointF(control->width()/2.0,control->height()/2.0));
            QTest::mouseClick(window,Qt::LeftButton,Qt::NoModifier,point.toPoint());
            QCoreApplication::processEvents();
            return true;
        };
        if(preview.rentalId()!="" ||
           !receipt->property("text").toString().contains("not issued") ||
           !click("p7PreviewButton") ||
           !quote->property("text").toString().contains("R 1350.00") ||
           !preview.committedStateConsistent() ||
           metrics.count()!=0 || readModel.activeCount()!=0){
            qCritical()<<"P7-J uncommitted quote incorrectly refreshed shared RentalListModel";
            app.exit(6);return;
        }
        if(app.arguments()[1]=="rollback") {
            if(!preview.rejectNextBookingForTest() ||
               !click("p7ConfirmButton") ||
               !preview.committedStateConsistent() ||
               preview.rentalId()!="" ||
               !receipt->property("text").toString().contains("not issued") ||
               metrics.count()!=0 || readModel.count()!=0 ||
               !click("p7ConfirmButton")) {
                qCritical()<<"P7-I rejected transaction issued false UI receipt";
                app.exit(7);return;
            }
        } else {
            if(!click("p7ConfirmButton")){app.exit(8);return;}
        }
        if(preview.rentalId()!="R001" ||
           !preview.committedStateConsistent() ||
           !receipt->property("text").toString().contains("R001") ||
           !state->property("text").toString().contains("ACTIVE") ||
           !preview.independentReopen() ||
           readModel.activeCount()!=1 || readModel.historyCount()!=0 ||
           readModel.count()!=1 || readModel.activeBookedValue()!=1350.0 ||
           metrics.count()!=1 ||
           !shared->property("text").toString().contains("Active rentals: 1") ||
           !readModel.selectById("r001") ||
           readModel.selectedContract().value("status").toString()!="Active"){
            qCritical()<<"P7-J shared RentalListModel did not reflect committed SQL booking";
            app.exit(9);return;
        }
        if(!click("p7ReturnButton") || !preview.committedStateConsistent() ||
           readModel.activeCount()!=0 || readModel.historyCount()!=1 ||
           readModel.selectedContract().value("status").toString()!="Returned" ||
           !click("p7ArchiveButton") || !preview.committedStateConsistent() ||
           readModel.selectedContract().value("status").toString()!="Archived" ||
           !click("p7RetireButton") || !preview.committedStateConsistent() ||
           !state->property("text").toString().contains("RETIRED") ||
           !preview.independentReopen() ||
           readModel.historyCount()!=1 || readModel.activeCount()!=0 ||
           metrics.count()!=4 ||
           !shared->property("text").toString().contains("History: 1")) {
            qCritical()<<"P7-I return/archive/retire not durable through Qt";
            app.exit(10);return;
        }
        if(app.arguments()[1]=="read_model") {
            readModel.setStatusFilter("Active");
            if(readModel.count()!=0 || readModel.activeCount()!=0 ||
               readModel.historyCount()!=1 || !readModel.locateById("R001") ||
               readModel.selectedContract().value("status").toString()!="Archived"){
                qCritical()<<"P7-J existing RentalListModel failed status filter and locate";
                app.exit(12);return;
            }
            const auto *repo=preview.testOnlyReadRepository();
            const auto fleet=repo?p7fiction::ReadProjection(*repo).fleet():std::nullopt;
            if(!fleet || fleet->size()!=1 || fleet->front().available ||
               fleet->front().details!="4 doors") {
                qCritical()<<"P7-J read-only Fleet mapping ignored retired occupancy";
                app.exit(13);return;
            }
        }
        qInfo()<<"P7-J existing shared Rentals read model / native QML PASS"
               <<app.arguments()[1]<<"R001 fictional, zero contact fields";
        app.exit(0);
    });
    return app.exec();
}
