#include "fleet_photo_store.h"
#include <QBuffer>
#include <QDir>
#include <QFileInfo>
#include <QFile>
#include <QImageReader>
#include <QRegularExpression>
#include <QSaveFile>

namespace {
bool safeId(const QString &id) {
    static const QRegularExpression pattern(QStringLiteral("^[CM][0-9]{3,8}$"));
    return pattern.match(id).hasMatch();
}
QString seed(const QString &id) {
    if(id==QStringLiteral("C001"))
        return QStringLiteral(":/fleet-demo-photos/toyota_corolla.jpg");
    if(id==QStringLiteral("C002"))
        return QStringLiteral(":/fleet-demo-photos/ford_ranger.jpg");
    if(id==QStringLiteral("C003"))
        return QStringLiteral(":/fleet-demo-photos/hyundai_i20.jpg");
    // Two motorcycles do not yet have licensed/approved model images.
    return {};
}
// Only app-reencoded fictional sidecars are expected on disk. Validate
// bounds from image headers before ever asking Qt to decompress the pixels.
bool safeSidecarFolder(const QString &root) {
    const QFileInfo folder(QDir(root).filePath(QStringLiteral("fleet_images")));
    return folder.isDir() && !folder.isSymLink();
}
bool safeSidecar(const QString &root,const QString &file) {
    const QFileInfo info(file);
    if(!safeSidecarFolder(root) || !info.isFile() || info.isSymLink() ||
       info.size()<=0 || info.size()>8*1024*1024)return false;
    QImageReader reader(file);
    const QSize dimensions=reader.size();
    return dimensions.isValid() && dimensions.width()<=1280 &&
           dimensions.height()<=960 && reader.canRead();
}
}

FleetPhotoStore::FleetPhotoStore(const QString &fictionalRoot,QObject *parent)
    : QObject(parent),m_root(fictionalRoot) {}

QString FleetPhotoStore::seededResource(const QString &id) const {
    return seed(id);
}
QString FleetPhotoStore::imagePath(const QString &id) const {
    return QDir(m_root).filePath(QStringLiteral("fleet_images/%1.png").arg(id));
}
bool FleetPhotoStore::hasPhoto(const QString &id) const {
    if(!safeId(id))return false;
    const QString file=imagePath(id);
    if(QFileInfo::exists(file)) {
        // Refuse tampered sidecars before Qt allocates decoded pixels.
        return safeSidecar(m_root,file);
    }
    const auto resource=seededResource(id);
    return !resource.isEmpty() && QImageReader(resource).canRead();
}
QImage FleetPhotoStore::imageFor(const QString &id,const QSize &requested) const {
    if(!safeId(id))return {};
    const QString file=imagePath(id);
    const bool local=QFileInfo::exists(file);
    if(local && !safeSidecar(m_root,file))return {};
    const QString origin=local?file:seededResource(id);
    if(origin.isEmpty())return {};
    QImageReader reader(origin);
    reader.setAutoTransform(true);
    // The provider sees only fixed repo resources or our re-encoded PNG.
    QImage image=reader.read();
    if(image.isNull())return {};
    if(requested.isValid() && requested.width()>0 && requested.height()>0)
        image=image.scaled(requested,Qt::KeepAspectRatio,Qt::SmoothTransformation);
    return image;
}
bool FleetPhotoStore::chooseFile(const QUrl &file) {
    m_staged=QImage{};
    m_feedback.clear();
    if(!file.isLocalFile()) {
        m_feedback=QStringLiteral("Choose a local PNG, JPEG or WebP image.");
        ++m_revision;emit changed();return false;
    }
    const QFileInfo info(file.toLocalFile());
    if(!info.isFile() || !info.isReadable() || info.isSymLink() ||
       info.size()<=0 || info.size()>12*1024*1024) {
        m_feedback=QStringLiteral("Choose a readable photo under 12 MB.");
        ++m_revision;emit changed();return false;
    }
    QImageReader reader(info.absoluteFilePath());
    reader.setAutoTransform(true);
    const auto fmt=reader.format().toLower();
    const QSize dimensions=reader.size();
    const qint64 pixels=qint64(dimensions.width())*dimensions.height();
    if((fmt!="png" && fmt!="jpeg" && fmt!="jpg" && fmt!="webp") ||
       !dimensions.isValid() || pixels<=0 || pixels>16000000) {
        m_feedback=QStringLiteral("Use a valid PNG, JPEG or WebP with at most 16 megapixels.");
        ++m_revision;emit changed();return false;
    }
    QImage raw=reader.read();
    if(raw.isNull()) {
        m_feedback=QStringLiteral("The selected photo could not be decoded.");
        ++m_revision;emit changed();return false;
    }
    m_staged=(raw.width()>1280 || raw.height()>960)
        ? raw.scaled(1280,960,Qt::KeepAspectRatio,Qt::SmoothTransformation)
        : raw;
    m_feedback=QStringLiteral("Photo ready for this fictional demo vehicle.");
    ++m_revision;emit changed();return true;
}
void FleetPhotoStore::discardStaged() {
    m_staged=QImage{};
    m_feedback.clear();
    ++m_revision;emit changed();
}
bool FleetPhotoStore::saveStagedFor(const QString &id) {
    if(m_staged.isNull())return true; // A fallback silhouette is valid.
    if(!safeId(id)) {
        m_feedback=QStringLiteral("Photo not attached: unsafe vehicle ID.");
        ++m_revision;emit changed();return false;
    }
    QByteArray png;
    QBuffer buffer(&png);
    if(!buffer.open(QIODevice::WriteOnly) || !m_staged.save(&buffer,"PNG") ||
       png.isEmpty() || png.size()>8*1024*1024) {
        m_feedback=QStringLiteral("Photo could not be prepared.");
        ++m_revision;emit changed();return false;
    }
    QDir dir(m_root);
    if(!dir.mkpath(QStringLiteral("fleet_images")) ||
       !safeSidecarFolder(m_root) || QFileInfo(imagePath(id)).isSymLink()) {
        m_feedback=QStringLiteral("Photo folder is not a safe fictional directory.");
        ++m_revision;emit changed();return false;
    }
    QSaveFile out(imagePath(id));
    if(!out.open(QIODevice::WriteOnly) || out.write(png)!=png.size() ||
       !out.commit()) {
        out.cancelWriting();
        m_feedback=QStringLiteral("Vehicle saved but photo could not be attached.");
        ++m_revision;emit changed();return false;
    }
    m_staged=QImage{};
    m_feedback=QStringLiteral("Photo attached to fictional vehicle.");
    ++m_revision;emit changed();return true;
}
void FleetPhotoStore::forgetVehicle(const QString &id) {
    if(!safeId(id))return;
    if(!safeSidecarFolder(m_root))return;
    const QString path=imagePath(id);
    if(QFileInfo::exists(path) && !QFileInfo(path).isSymLink())
        QFile::remove(path);
    ++m_revision;emit changed();
}
QImage FleetPhotoProvider::requestImage(const QString &id,QSize *size,
                                         const QSize &requestedSize) {
    // Image URL query is used only to force refresh when a photo is changed.
    const QString key=id.section(QLatin1Char('?'),0,0);
    QImage result=key==QStringLiteral("__staged")
        ? m_store.stagedImage(requestedSize)
        : m_store.imageFor(key,requestedSize);
    if(size)*size=result.size();
    return result;
}
