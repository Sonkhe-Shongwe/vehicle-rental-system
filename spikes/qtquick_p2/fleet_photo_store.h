#pragma once
#include <QObject>
#include <QImage>
#include <QUrl>
#include <QQuickImageProvider>
#include <QString>

class FleetPhotoStore final : public QObject {
    Q_OBJECT
    Q_PROPERTY(bool hasStaged READ hasStaged NOTIFY changed)
    Q_PROPERTY(QString feedback READ feedback NOTIFY changed)
    Q_PROPERTY(int revision READ revision NOTIFY changed)
public:
    explicit FleetPhotoStore(const QString &fictionalRoot, QObject *parent=nullptr);
    bool hasStaged() const { return !m_staged.isNull(); }
    QString feedback() const { return m_feedback; }
    int revision() const { return m_revision; }
    Q_INVOKABLE bool chooseFile(const QUrl &file);
    Q_INVOKABLE void discardStaged();
    Q_INVOKABLE bool hasPhoto(const QString &vehicleId) const;
    bool saveStagedFor(const QString &vehicleId);
    void forgetVehicle(const QString &vehicleId);
    QImage imageFor(const QString &vehicleId, const QSize &requestedSize={}) const;
    QImage stagedImage(const QSize &requestedSize={}) const {
        if(m_staged.isNull())return {};
        return requestedSize.isValid()
            ? m_staged.scaled(requestedSize,Qt::KeepAspectRatio,Qt::SmoothTransformation)
            : m_staged;
    }
signals:
    void changed();
private:
    QString imagePath(const QString &vehicleId) const;
    QString seededResource(const QString &vehicleId) const;
    QString m_root;
    QString m_feedback;
    QImage m_staged;
    int m_revision=0;
};

class FleetPhotoProvider final : public QQuickImageProvider {
public:
    explicit FleetPhotoProvider(const FleetPhotoStore &store)
        : QQuickImageProvider(QQuickImageProvider::Image), m_store(store) {}
    QImage requestImage(const QString &id, QSize *size,
                        const QSize &requestedSize) override;
private:
    const FleetPhotoStore &m_store;
};
