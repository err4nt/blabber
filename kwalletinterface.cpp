#include "kwalletinterface.h"
#include <QGuiApplication>

KWalletInterface::KWalletInterface(QQmlApplicationEngine * engine)
{
    m_engine = engine;
}

WId KWalletInterface::findWindowId()
{
    QWindowList list = QGuiApplication::topLevelWindows();
    return list.first()->winId();
}

void KWalletInterface::openWallet(void)
{
    m_wallet = Wallet::openWallet(Wallet::NetworkWallet(),
                                  findWindowId(),
                                  Wallet::Asynchronous);

    connect(m_wallet, SIGNAL(walletOpened(bool)), SLOT(walletOpened(bool)));
}

void KWalletInterface::walletOpened(bool ok)
{
    if (ok &&
        (m_wallet->hasFolder(KWallet::Wallet::PasswordFolder()) ||
         m_wallet->createFolder(KWallet::Wallet::PasswordFolder())) &&
         m_wallet->setFolder(KWallet::Wallet::PasswordFolder()))
    {
        qDebug() << "Wallet opened";
        emit walletReady();
    }
    else
    {
        qDebug() << "Wallet failure";
    }
}

void KWalletInterface::storeCredentials(QString instanceUrl, QString clientId, QString clientSecret, QString clientToken, QString refreshToken, QDateTime expires)
{
    QMap<QString, QString> map;
    map["clientId"] = clientId;
    map["clientSecret"] = clientSecret;
    map["clientToken"] = clientToken;
    map["instanceUrl"] = instanceUrl;
    map["refreshToken"] = refreshToken;
    map["expires"] = expires.toString();
    if(m_wallet->writeMap("BlabberKeys", map))
    {
        qDebug() << "Error saving keys";
    }
    else
    {
        qDebug() << "Keys saved";
    }
}

void KWalletInterface::loadCredentials()
{
    if(m_wallet->keyDoesNotExist(KWallet::Wallet::NetworkWallet(), KWallet::Wallet::PasswordFolder(), "BlabberKeys"))
    {
        emit KWalletInterface::keysNotFound();
    }
    else
    {
        QMap<QString, QString> map;
        m_wallet->readMap(QString("BlabberKeys"), map);
        emit KWalletInterface::keysLoaded(map["instanceUrl"],
                                          map["clientId"],
                                          map["clientSecret"],
                                          map["clientToken"],
                                          map["refreshToken"],
                                          QDateTime::fromString(map["expires"]));
    }
}
