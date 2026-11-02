// P7-H typed normalized SQLite candidate; generated fictional data only.
#include <QCoreApplication>
#include <QDir>
#include <QFile>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QTemporaryDir>
#include <QUuid>
#include <QDebug>
#include <memory>
#include "src/application/p7_sandbox/sqlite_repository.h"
using p7fiction::Repository;using p7fiction::Status;
namespace {
bool ok(bool b,const char *why){if(!b)qCritical()<<"P7-H FAIL:"<<why;return b;}
const QDate day=QDate::fromString("2026-11-02",Qt::ISODate);
struct Temp {
    QTemporaryDir dir{QDir::tempPath()+"/rental-p7h-XXXXXX"};
    Temp(){QFile f(dir.filePath(".fictional-only"));
        if(f.open(QIODevice::WriteOnly|QIODevice::NewOnly))
            f.write("P7-H GENERATED FICTIONAL ONLY\n");}
    std::unique_ptr<Repository> open(){return std::make_unique<Repository>(dir.path());}
};
bool seed(Repository &r){
    QString c,m;
    return ok(r.createNew()&&r.integrity(),"create normalized v1")&&
           ok(r.vehicle("Car","Toyota","Corolla","450.00",4,&c)==Status::Ok&&c=="C001","C001")&&
           ok(r.vehicle("Motorcycle","Honda","CB500F","280.00",471,&m)==Status::Ok&&m=="M001","M001");
}
bool lifecycle(){
    Temp t;auto r=t.open();if(!seed(*r))return false;
    auto q=r->quote("c001",3,day);
    if(!ok(q&&q->dailyCents==45000&&q->totalCents==135000,"exact cents quote"))return false;
    auto result=r->book(*q,day);
    if(!ok(result.status==Status::Ok&&result.id=="R001","committed R001")||
       !ok(r->next("R")==2&&r->count("rentals")==1,"durable allocation")||
       !ok(!r->quote("C001",2,day)&&r->book(*q,day).status==Status::Unavailable,"duplicate denied")||
       !ok(r->retire("C001")==Status::Unavailable,"rented vehicle retirement blocked"))return false;
    r.reset();r=t.open();auto rec=r->rental("R001");
    if(!ok(r->ready()&&rec&&rec->totalCents==135000&&rec->status=="ACTIVE","independent reopen"))return false;
    if(!ok(r->returnRental("R001",day,day)==Status::Ok,"return")||
       !ok(r->returnRental("R001",day,day)==Status::Unavailable,"no duplicate return")||
       !ok(r->archive("R001")==Status::Ok,"archive")||
       !ok(r->retire("C001")==Status::Ok,"non-destructive retirement"))return false;
    r.reset();r=t.open();rec=r->rental("R001");
    return ok(r->integrity()&&rec&&rec->status=="ARCHIVED"&&
              r->state("C001")=="RETIRED"&&!r->quote("C001",1,day),
              "history preserved across reopen");
}
bool rollback(){
    Temp t;auto r=t.open();if(!seed(*r))return false;
    auto q=r->quote("C001",3,day);if(!q)return false;
    r->failNextCommitForTest();
    auto refused=r->book(*q,day);
    if(!ok(refused.status==Status::Failed&&refused.id.isEmpty()&&
           r->next("R")==1&&r->count("rentals")==0,"rollback ID and booking"))return false;
    if(!ok(r->book(*q,day).id=="R001","retry no consumed ID")||
       !ok(r->returnRental("R001",day,day)==Status::Ok,"return"))return false;
    r->failNextCommitForTest();
    if(!ok(r->archive("R001")==Status::Failed&&
           r->rental("R001")->status=="RETURNED","archive rollback"))return false;
    return ok(r->archive("R001")==Status::Ok,"archive retry");
}
bool numbers(){
    if(!ok(Repository::cents("0.01")==1&&Repository::cents("450.00")==45000&&
           !Repository::cents("0.00")&&!Repository::cents("1.001")&&
           !Repository::cents("-2.00")&&!Repository::cents("1e3")&&
           !Repository::cents("92233720368547758.08"),"strict cents"))return false;
    Temp t;auto r=t.open();if(!seed(*r))return false;
    QString id="old";
    if(!ok(r->vehicle("Car","bad","price","0.00",4,&id)==Status::Invalid&&
           id.isEmpty()&&r->next("C")==2,"invalid does not issue ID"))return false;
    auto q=r->quote("C001",2,day);if(!q)return false;
    auto stale=*q;stale.totalCents+=1;
    if(!ok(r->book(stale,day).status==Status::Stale&&r->next("R")==1,
           "stale quote rejected before ID allocation"))return false;
    if(!ok(r->vehicle("Car","New","Asset","320.01",4,&id)==Status::Ok&&id=="C002","C002"))return false;
    r.reset();r=t.open();
    return ok(r->ready()&&r->next("C")==3,"ID high-water across reboot");
}
bool future(){
    Temp t;auto r=t.open();if(!seed(*r))return false;r.reset();
    const QString name="p7h-"+QUuid::createUuid().toString(QUuid::WithoutBraces);
    {auto db=QSqlDatabase::addDatabase("QSQLITE",name);
     db.setDatabaseName(t.dir.filePath("fictional.sqlite"));
     if(!db.open())return false;
     {QSqlQuery q(db);if(!q.exec("PRAGMA user_version=2"))return false;}
     db.close();}
    QSqlDatabase::removeDatabase(name);
    r=t.open();
    return ok(!r->ready()&&!r->createNew()&&
              r->vehicle("Car","x","y","10.00",4)==Status::Invalid,
              "newer schema fails closed");
}
bool contention(){
    Temp t;auto r=t.open();if(!seed(*r))return false;
    const QString name="p7h-lock-"+QUuid::createUuid().toString(QUuid::WithoutBraces);
    {auto db=QSqlDatabase::addDatabase("QSQLITE",name);
     db.setDatabaseName(t.dir.filePath("fictional.sqlite"));
     if(!db.open())return false;
     {QSqlQuery q(db);if(!q.exec("PRAGMA busy_timeout=0")||!q.exec("BEGIN IMMEDIATE"))return false;}
     if(!ok(r->vehicle("Car","x","y","200.00",4)==Status::Failed&&r->next("C")==2,
            "writer lock refusal preserves ID"))return false;
     {QSqlQuery q(db);if(!q.exec("ROLLBACK"))return false;}
     db.close();}
    QSqlDatabase::removeDatabase(name);
    QString id;
    return ok(r->vehicle("Car","New","Asset","200.00",4,&id)==Status::Ok&&id=="C002",
              "successful retry");
}
}
int main(int argc,char**argv){
    QCoreApplication app(argc,argv);if(app.arguments().size()!=2)return 2;
    const QString mode=app.arguments()[1];
    bool pass=mode=="lifecycle"?lifecycle():mode=="rollback"?rollback():
       mode=="money_ids"?numbers():mode=="future_schema"?future():
       mode=="contention"?contention():false;
    if(pass)qInfo()<<"P7-H normalized fictional-only repository PASS"<<mode;
    return pass?0:1;
}
