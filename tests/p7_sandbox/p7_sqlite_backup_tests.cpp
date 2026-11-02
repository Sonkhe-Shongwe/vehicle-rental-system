// P7-E: independently compiled, OFF-by-default, synthetic-only backup/recovery proof.
// No RentalSystem, QML, arbitrary file arguments, customer data or runtime integration.
#include <QCoreApplication>
#include <QCryptographicHash>
#include <QFile>
#include <QFileInfo>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QTemporaryDir>
#include <QUuid>
#include <QVariant>
#include <QDebug>

static bool check(bool ok, const char *message) {
    if (!ok) qCritical() << "P7-E synthetic-only FAIL:" << message;
    return ok;
}

class Database {
    const QString connectionName =
        QStringLiteral("p7e-") + QUuid::createUuid().toString(QUuid::WithoutBraces);
public:
    QSqlDatabase db;
    ~Database() {
        db.close();
        db = QSqlDatabase();
        QSqlDatabase::removeDatabase(connectionName);
    }
    bool open(const QString &path, bool wal = true) {
        if (!check(QSqlDatabase::isDriverAvailable("QSQLITE"), "SQLite driver")) return false;
        db = QSqlDatabase::addDatabase("QSQLITE", connectionName);
        db.setDatabaseName(path);
        if (!check(db.open(), "SQLite open")) return false;
        return exec("PRAGMA busy_timeout=0") &&
               exec("PRAGMA foreign_keys=ON") &&
               exec(wal ? "PRAGMA journal_mode=WAL" : "PRAGMA journal_mode=DELETE") &&
               exec("PRAGMA synchronous=FULL") &&
               check(value("PRAGMA foreign_keys").toInt() == 1, "FK enabled");
    }
    bool exec(const QString &sql) {
        QSqlQuery q(db);
        return q.exec(sql);
    }
    bool run(const QString &sql, const QVariantList &params = {}) {
        QSqlQuery q(db);
        if (!q.prepare(sql)) return false;
        for (const QVariant &v : params) q.addBindValue(v);
        return q.exec();
    }
    QVariant value(const QString &sql) {
        QSqlQuery q(db);
        return q.exec(sql) && q.next() ? q.value(0) : QVariant();
    }
    bool integrity() {
        if (!db.isOpen() || value("PRAGMA user_version").toInt() != 1 ||
            value("PRAGMA integrity_check").toString() != QStringLiteral("ok") ||
            value("PRAGMA foreign_keys").toInt() != 1) return false;
        QSqlQuery fk(db);
        return fk.exec("PRAGMA foreign_key_check") && !fk.next();
    }
    bool seed() {
        if (!db.transaction()) return false;
        const QStringList statements = {
            "CREATE TABLE issued(kind TEXT PRIMARY KEY, next_id INTEGER NOT NULL CHECK(next_id > 0))",
            "INSERT INTO issued VALUES('C',3),('R',3)",
            "CREATE TABLE vehicles(id TEXT PRIMARY KEY COLLATE NOCASE, state TEXT NOT NULL "
                "CHECK(state IN ('ACTIVE','RETIRED')), rate_cents INTEGER NOT NULL CHECK(rate_cents > 0))",
            "CREATE TABLE rentals(id TEXT PRIMARY KEY COLLATE NOCASE, vehicle_id TEXT NOT NULL "
                "REFERENCES vehicles(id) ON DELETE RESTRICT, status TEXT NOT NULL "
                "CHECK(status IN ('ACTIVE','RETURNED','ARCHIVED')), total_cents INTEGER NOT NULL "
                "CHECK(total_cents > 0))",
            "CREATE UNIQUE INDEX active_vehicle ON rentals(vehicle_id COLLATE NOCASE) WHERE status='ACTIVE'",
            "INSERT INTO vehicles VALUES('C001','ACTIVE',45000),('C002','RETIRED',42000)",
            "INSERT INTO rentals VALUES('R001','C001','ACTIVE',135000),"
                "('R002','C002','ARCHIVED',84000)",
            "PRAGMA user_version=1"
        };
        for (const QString &sql : statements) {
            if (!exec(sql)) { db.rollback(); return false; }
        }
        return db.commit() && integrity();
    }
    bool baseline() {
        return integrity() &&
               value("SELECT count(*) FROM vehicles").toInt() == 2 &&
               value("SELECT count(*) FROM rentals").toInt() == 2 &&
               value("SELECT sum(total_cents) FROM rentals").toLongLong() == 219000 &&
               value("SELECT count(*) FROM rentals WHERE status='ACTIVE'").toInt() == 1 &&
               value("SELECT state FROM vehicles WHERE id='C002'").toString() == "RETIRED" &&
               value("SELECT next_id FROM issued WHERE kind='C'").toInt() == 3 &&
               value("SELECT next_id FROM issued WHERE kind='R'").toInt() == 3;
    }
};

// VACUUM INTO makes a consistent snapshot, not a live DB file copy.
// The candidate is validated in private staging and renamed only if the final
// path is absent. It has no API capable of accepting arbitrary user paths.
static bool backup(Database &source, const QString &destination) {
    const QString staging = destination + QStringLiteral(".stage");
    if (QFileInfo::exists(destination) || QFileInfo::exists(staging) ||
        !source.integrity()) return false;
    QSqlQuery vacuum(source.db);
    if (!vacuum.prepare("VACUUM INTO ?")) return false;
    vacuum.addBindValue(staging);
    if (!vacuum.exec()) {
        vacuum.finish();
        QFile::remove(staging);
        return false;
    }
    vacuum.finish();
    bool validStage = false;
    {
        Database staged;
        validStage = staged.open(staging) && staged.integrity();
    }
    if (!validStage) {
        QFile::remove(staging);
        return false;
    }
    // QFile::rename refuses an existing destination. Never remove it.
    QFile file(staging);
    if (!file.rename(destination)) {
        QFile::remove(staging);
        return false;
    }
    return QFileInfo(destination).size() > 0;
}
static QByteArray sha256(const QString &path) {
    QFile file(path);
    if (!file.open(QIODevice::ReadOnly)) return {};
    QCryptographicHash h(QCryptographicHash::Sha256);
    return h.addData(&file) ? h.result() : QByteArray();
}
static bool makeSeed(const QString &path) {
    Database db;
    return db.open(path) && db.seed() && db.baseline();
}
static bool restored(const QString &path) {
    Database db;
    return db.open(path) && db.baseline();
}

static bool snapshot() {
    QTemporaryDir dir;
    if (!check(dir.isValid(), "temporary root")) return false;
    const QString src = dir.filePath("source.sqlite");
    const QString dst = dir.filePath("restored.sqlite");
    if (!makeSeed(src)) return false;
    {
        Database db;
        if (!db.open(src) || !backup(db, dst)) return false;
        if (!check(sha256(dst).size() == 32, "snapshot SHA256")) return false;
        if (!check(db.run("INSERT INTO vehicles VALUES('C003','ACTIVE',10000)"),
                   "later source-only change")) return false;
    }
    Database copy;
    return check(copy.open(dst) && copy.baseline(), "restored snapshot excludes later writes") &&
           check(copy.run("INSERT INTO vehicles VALUES('C003','ACTIVE',20000)"),
                 "restore is independently writable") &&
           check(copy.value("SELECT count(*) FROM vehicles").toInt() == 3,
                 "restored copy is independent");
}

static bool readers() {
    QTemporaryDir dir;
    if (!dir.isValid()) return false;
    const QString src = dir.filePath("source.sqlite");
    const QString dst = dir.filePath("backup.sqlite");
    if (!makeSeed(src)) return false;
    Database writer, reader;
    if (!writer.open(src) || !reader.open(src)) return false;
    QSqlQuery cursor(reader.db);
    if (!check(cursor.exec("SELECT id FROM rentals ORDER BY id") && cursor.next(),
               "independent reader remains open")) return false;
    if (!check(backup(writer, dst), "snapshot with active reader")) return false;
    return check(cursor.next() && cursor.value(0).toString() == "R002",
                 "reader was not invalidated") &&
           check(restored(dst), "consistent restored copy with reader") &&
           check(writer.baseline(), "source unchanged with reader");
}

static bool uncommitted() {
    QTemporaryDir dir;
    if (!dir.isValid()) return false;
    const QString src = dir.filePath("source.sqlite");
    const QString dst = dir.filePath("backup.sqlite");
    if (!makeSeed(src)) return false;
    Database writer, snapshotter;
    if (!writer.open(src) || !snapshotter.open(src) || !writer.db.transaction()) return false;
    if (!check(writer.run("INSERT INTO vehicles VALUES('C003','ACTIVE',50000)"),
               "transactional uncommitted edit")) { writer.db.rollback(); return false; }
    const bool ok = backup(snapshotter, dst);
    const bool rolledBack = writer.db.rollback();
    return check(ok && rolledBack, "backup without dirty reads") &&
           check(restored(dst), "uncommitted edit excluded from backup") &&
           check(writer.baseline(), "rollback left original intact");
}

static bool damaged() {
    QTemporaryDir dir;
    if (!dir.isValid()) return false;
    const QString src = dir.filePath("source.sqlite");
    const QString dst = dir.filePath("good.sqlite");
    const QString damagedPath = dir.filePath("damaged.sqlite");
    if (!makeSeed(src)) return false;
    {
        Database db;
        if (!db.open(src) || !backup(db, dst)) return false;
    }
    const QByteArray goodHash = sha256(dst);
    if (!check(goodHash.size() == 32 && QFile::copy(dst, damagedPath),
               "copy backup for deliberate corruption")) return false;
    {
        QFile corrupt(damagedPath);
        if (!corrupt.open(QIODevice::ReadWrite) || !corrupt.seek(0) ||
            corrupt.write("NOT-SQLITE", 10) != 10) return false;
    }
    bool accepted = false;
    {
        Database candidate;
        accepted = candidate.open(damagedPath) && candidate.integrity();
    }
    return check(!accepted, "corrupt backup rejected") &&
           check(sha256(dst) == goodHash && restored(dst),
                 "good backup retained after rejected corrupt copy");
}

static bool refuseOverwrite() {
    QTemporaryDir dir;
    if (!dir.isValid()) return false;
    const QString src = dir.filePath("source.sqlite");
    const QString dst = dir.filePath("existing.sqlite");
    if (!makeSeed(src)) return false;
    QFile sentinel(dst);
    if (!sentinel.open(QIODevice::WriteOnly) ||
        sentinel.write("DO-NOT-OVERWRITE", 16) != 16) return false;
    sentinel.close();
    const QByteArray original = sha256(dst);
    Database db;
    return check(db.open(src), "open source") &&
           check(!backup(db, dst), "existing destination refused") &&
           check(sha256(dst) == original, "existing bytes untouched") &&
           check(!QFileInfo::exists(dst + ".stage"), "no partial staged backup") &&
           check(db.baseline(), "source unchanged after overwrite denial");
}

static bool locked() {
    QTemporaryDir dir;
    if (!dir.isValid()) return false;
    const QString src = dir.filePath("source.sqlite");
    const QString dst = dir.filePath("backup.sqlite");
    {
        Database db;
        if (!db.open(src, false) || !db.seed()) return false;
    }
    Database blocker, snapshotter;
    if (!blocker.open(src, false) || !snapshotter.open(src, false) ||
        !check(blocker.exec("BEGIN EXCLUSIVE"), "exclusive source lock")) return false;
    const bool denied = !backup(snapshotter, dst);
    const bool release = blocker.exec("ROLLBACK");
    if (!check(denied && release, "locked source backup refused") ||
        !check(!QFileInfo::exists(dst) && !QFileInfo::exists(dst + ".stage"),
               "no completed or partial backup under lock")) return false;
    return check(backup(snapshotter, dst), "backup retries after lock release") &&
           check(restored(dst), "restored data intact after lock retry");
}

int main(int argc, char **argv) {
    QCoreApplication app(argc, argv);
    if (argc != 2) return 2; // fixed test names only; never file paths
    const QString mode = QString::fromLatin1(argv[1]);
    bool ok = false;
    if (mode == "snapshot") ok = snapshot();
    else if (mode == "readers") ok = readers();
    else if (mode == "uncommitted") ok = uncommitted();
    else if (mode == "damaged") ok = damaged();
    else if (mode == "refuse_overwrite") ok = refuseOverwrite();
    else if (mode == "locked") ok = locked();
    else return 3;
    if (ok) qInfo() << "P7-E synthetic SQLite backup proof PASS:" << mode;
    return ok ? 0 : 1;
}
