#ifndef KWALLETINTERFACE_H
#define KWALLETINTERFACE_H

#include <QtCore/qglobal.h>
#include <QObject>
#include <KWallet/Wallet>
#include <QQmlApplicationEngine>
#include <QWindow>
#include <QtGui/qwindowdefs.h>
#include <QDebug>
#include <QString>
#include <QMap>
#include <QDateTime>

using KWallet::Wallet;

class KWalletInterface : public QObject
{
    Q_OBJECT
public:
    explicit KWalletInterface(QQmlApplicationEngine * engine);

    Q_INVOKABLE void openWallet(void);
    Q_INVOKABLE void storeCredentials(QString instanceUrl, QString clientId, QString clientSecret, QString clientToken, QString refreshToken, QDateTime expires);
    Q_INVOKABLE void loadCredentials(void);

signals:
    void walletNotFound();
    void walletReady();
    void keysLoaded(QString instanceUrl, QString clientId, QString clientSecret, QString clientToken, QString refreshToken, QDateTime expires);
    void keysNotFound();

public slots:

private slots:
    void walletOpened(bool ok);

private:
    WId findWindowId();

    WId m_wid;
    Wallet * m_wallet;
    QQmlApplicationEngine * m_engine;
};

#endif // KWALLETINTERFACE_H
