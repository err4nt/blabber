#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "mastodon.h"
#include "kwalletinterface.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    qmlRegisterType<mastodon>("org.voidptr.qmastodon", 1, 0, "QMastodon");

    QQmlApplicationEngine engine;
    KWalletInterface * wallet = new KWalletInterface(&engine);
    engine.rootContext()->setContextProperty("wallet", wallet);
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
