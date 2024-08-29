#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "transactionmanager.h"
<<<<<<< HEAD
int main(int argc, char *argv[])
{
=======
#include "transaction.h"

int main(int argc, char *argv[]) {
>>>>>>> 3fa0c2d4315cdce955e98c5a24a53f50c8ed2fd0
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
<<<<<<< HEAD
    TransactionManager transactionManager;

    engine.rootContext()->setContextProperty("transactionManager", &transactionManager);

    // Populate the database with initial data (run this only once)
    transactionManager.populateInitialData();

    // Load transactions initially
    transactionManager.loadTransactions();
    const QUrl url(QStringLiteral("qrc:/financial_tracker/main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
=======

    // Créer une instance de TransactionManager
    TransactionManager dbManager;
    dbManager.createTable();

    // Exposer la classe à QML
    engine.rootContext()->setContextProperty("dbManager", &dbManager);

    const QUrl url("qrc:/financial_tracker/main.qml");
>>>>>>> 3fa0c2d4315cdce955e98c5a24a53f50c8ed2fd0
    engine.load(url);

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
