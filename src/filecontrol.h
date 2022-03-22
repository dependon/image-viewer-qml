#ifndef FILECONTROL_H
#define FILECONTROL_H

#include <QObject>
#include <QFileInfo>

class OcrInterface;

class FileControl : public QObject
{
    Q_OBJECT
public:
    explicit FileControl(QObject *parent = nullptr);
    ~  FileControl();

    Q_INVOKABLE QString getDirPath(const QString &path);
    Q_INVOKABLE QStringList getDirImagePath(const QString &path);
    Q_INVOKABLE bool isImage(const QString &path);

    Q_INVOKABLE void setWallpaper(const QString &imgPath);

    Q_INVOKABLE bool deleteImagePath(const QString &path);

    Q_INVOKABLE bool displayinFileManager(const QString &path);

    Q_INVOKABLE void copyImage(const QString &path);

    Q_INVOKABLE bool isCanRotate(const QString &path);

    Q_INVOKABLE bool isCanWrite(const QString &path);

    Q_INVOKABLE bool isFileExist(const QString &path);

    Q_INVOKABLE void ocrImage(const QString &path);

signals:

public slots:



private :
    OcrInterface *m_ocrInterface{nullptr};
};

#endif // FILECONTROL_H
