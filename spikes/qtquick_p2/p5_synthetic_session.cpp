#include "p5_synthetic_session.h"
#include <QDate>
#include <QDir>
#include <QFile>
#include <QFileInfo>
#include <QRegularExpression>
#include <QSaveFile>
#include <QStandardPaths>
#include <QStringList>
#include <cmath>

namespace {
void error(QString *out,const QString &message) { if(out) *out=message; }
bool readFile(const QString &path,QByteArray *result) {
    QFile file(path);
    if(!file.open(QIODevice::ReadOnly))return false;
    *result=file.readAll();
    return file.error()==QFile::NoError;
}
bool atomicFile(const QString &path,const QByteArray &value) {
    QSaveFile file(path);
    return file.open(QIODevice::WriteOnly) &&
           file.write(value)==value.size() && file.commit();
}
bool ordinaryFile(const QString &path) {
    const QFileInfo info(path);
    return info.exists() && info.isFile() && !info.isSymLink();
}
bool correctEntries(const QDir &dir) {
    const QStringList entries=dir.entryList(QDir::AllEntries | QDir::Hidden |
                                            QDir::NoDotAndDotDot,QDir::Name);
    return entries==QStringList({"rentals.txt","session.marker","vehicles.txt"});
}
bool syntheticLedger(const QByteArray &bytes,const QByteArray &seed) {
    if(bytes.size()>65536 || bytes.isEmpty())return false;
    const QString content=QString::fromUtf8(bytes);
    if(content.toUtf8()!=bytes)return false;
    const QStringList records=content.split('\n',Qt::SkipEmptyParts);
    const QStringList original=QString::fromUtf8(seed).split('\n',Qt::SkipEmptyParts);
    if(records.size()<original.size() || records.size()>40 ||
       original.size()!=2)return false;
    const QRegularExpression id(QStringLiteral("^R[0-9]{3,8}$"));
    const QStringList fleet={"C001","C002","C003","M001","M002"};
    for(int i=0;i<records.size();++i) {
        const QStringList f=records.at(i).split('|',Qt::KeepEmptyParts);
        if(f.size()!=13 || f.at(0)!="Rental" ||
           !id.match(f.at(1)).hasMatch() || !fleet.contains(f.at(4)) ||
           f.at(3)!="0000000000") return false;
        if(i<original.size()) {
            const QStringList expected=original.at(i).split('|',Qt::KeepEmptyParts);
            // Seed details cannot be replaced by customer data. Only lifecycle
            // return/archive flags or actual return date may legitimately change.
            for(const int k:{0,1,2,3,4,5,6,8,9,10})
                if(f.at(k)!=expected.at(k))return false;
        } else if(f.at(2)!="Fictional Demo Session") {
            return false;
        }
        if(f.at(11)!="0" && f.at(11)!="1")return false;
        if(f.at(12)!="0" && f.at(12)!="1")return false;
        const bool returned=f.at(11)=="1";
        if(f.at(12)=="1" && !returned)return false;
        const QDate start=QDate::fromString(f.at(5),Qt::ISODate);
        const QDate due=QDate::fromString(f.at(6),Qt::ISODate);
        const QDate actual=QDate::fromString(f.at(7),Qt::ISODate);
        bool daysOk=false,rateOk=false,totalOk=false;
        const int days=f.at(8).toInt(&daysOk);
        const double rate=f.at(9).toDouble(&rateOk);
        const double total=f.at(10).toDouble(&totalOk);
        if(!daysOk || days<1 || days>365 || !rateOk || !totalOk ||
           !std::isfinite(rate) || !std::isfinite(total) || rate<=0 ||
           std::abs(rate*days-total)>0.01 ||
           !start.isValid() || due!=start.addDays(days) ||
           (returned && (!actual.isValid() || actual<start)) ||
           (!returned && !f.at(7).isEmpty()))return false;
        for(int j=0;j<i;++j)
            if(records.at(j).section('|',1,1)==f.at(1))return false;
    }
    return true;
}
} // namespace

QString P5SyntheticSession::location() {
    return QDir(QStandardPaths::writableLocation(QStandardPaths::AppLocalDataLocation))
        .filePath(QStringLiteral("rental-studio-p5-fictional-only-v1"));
}

bool P5SyntheticSession::validate(const QByteArray &vehiclesSeed,
                                  const QByteArray &rentalsSeed,
                                  const QByteArray &marker,QString *reason) {
    const QFileInfo info(location());
    if(!info.exists() || !info.isDir() || info.isSymLink()) {
        error(reason,QStringLiteral("Untrusted session directory"));
        return false;
    }
    const QDir dir(location());
    QByteArray m,v,r;
    if(!correctEntries(dir) ||
       !ordinaryFile(dir.filePath("session.marker")) ||
       !ordinaryFile(dir.filePath("vehicles.txt")) ||
       !ordinaryFile(dir.filePath("rentals.txt")) ||
       !readFile(dir.filePath("session.marker"),&m) ||
       !readFile(dir.filePath("vehicles.txt"),&v) ||
       !readFile(dir.filePath("rentals.txt"),&r) ||
       m!=marker || v!=vehiclesSeed || !syntheticLedger(r,rentalsSeed)) {
        error(reason,QStringLiteral("Unexpected files or non-fictional demo data; refusing to load"));
        return false;
    }
    return true;
}

bool P5SyntheticSession::open(const QByteArray &vehiclesSeed,
                              const QByteArray &rentalsSeed,
                              const QByteArray &marker,QString *reason) {
    if(QFileInfo::exists(location()))
        return validate(vehiclesSeed,rentalsSeed,marker,reason);
    const QFileInfo parent(QFileInfo(location()).absolutePath());
    if(parent.exists() && (!parent.isDir() || parent.isSymLink())) {
        error(reason,QStringLiteral("Untrusted application-data parent"));
        return false;
    }
    if(!QDir().mkpath(location())) {
        error(reason,QStringLiteral("Cannot create fictional session"));
        return false;
    }
    const QDir dir(location());
    // Write marker LAST. Interrupted initialization is rejected next launch.
    if(!atomicFile(dir.filePath("vehicles.txt"),vehiclesSeed) ||
       !atomicFile(dir.filePath("rentals.txt"),rentalsSeed) ||
       !atomicFile(dir.filePath("session.marker"),marker)) {
        error(reason,QStringLiteral("Could not initialize fictional session"));
        return false;
    }
    return validate(vehiclesSeed,rentalsSeed,marker,reason);
}

bool P5SyntheticSession::cleanForTest(const QByteArray &marker,QString *reason) {
    const QDir dir(location());
    if(!dir.exists())return true;
    QByteArray actual;
    if(!correctEntries(dir) ||
       !ordinaryFile(dir.filePath("session.marker")) ||
       !readFile(dir.filePath("session.marker"),&actual) ||
       actual!=marker) {
        error(reason,QStringLiteral("Refusing to clean unidentified test data"));
        return false;
    }
    for(const QString &file:{"rentals.txt","vehicles.txt","session.marker"})
        if(!QFile::remove(dir.filePath(file)))return false;
    return QDir().rmdir(location());
}
