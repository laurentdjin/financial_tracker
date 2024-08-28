#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "transactionmanager.h"
#include "transaction.h"

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // Créer une instance de TransactionManager
    TransactionManager dbManager;
    dbManager.createTable();

    // Exposer la classe à QML
    engine.rootContext()->setContextProperty("dbManager", &dbManager);

    const QUrl url("qrc:/financial_tracker/main.qml");
    engine.load(url);

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
