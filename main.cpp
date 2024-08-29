#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "transactionmanager.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
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
    engine.load(url);

    return app.exec();
}
