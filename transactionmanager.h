#ifndef TRANSACTIONMANAGER_H
#define TRANSACTIONMANAGER_H

#include <QObject>
<<<<<<< HEAD
#include <QList>
#include <QSqlDatabase>
#include "transaction.h"

class TransactionManager : public QObject {
    Q_OBJECT
    Q_PROPERTY(QList<QObject*> transactions READ transactions NOTIFY transactionsChanged)
=======
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlRecord>
#include <QStringList>

class TransactionManager : public QObject {
    Q_OBJECT
    Q_PROPERTY(QStringList peopleModel READ peopleModel NOTIFY peopleModelChanged)
>>>>>>> 3fa0c2d4315cdce955e98c5a24a53f50c8ed2fd0

public:
    explicit TransactionManager(QObject *parent = nullptr);
    ~TransactionManager();

<<<<<<< HEAD
    Q_INVOKABLE void loadTransactions(); // Fetch transactions from the database

    Q_INVOKABLE void populateInitialData(); // Populate the database with initial data

    QList<QObject*> transactions() const { return m_transactions; }

signals:
    void transactionsChanged();

private:
    QSqlDatabase m_db;
    QList<QObject*> m_transactions;
    void setupDatabase();
=======
    Q_INVOKABLE bool createTable();
    Q_INVOKABLE bool insertData(const QString &username, const QString &password);
    Q_INVOKABLE bool clearDatabase();
    Q_INVOKABLE bool dropTable();
    Q_INVOKABLE bool checkCredentials(const QString &username, const QString &password);

    QStringList peopleModel();

signals:
    void peopleModelChanged();

private:
    void updateModel();
    QSqlDatabase m_db;
    QStringList m_peopleModel;
>>>>>>> 3fa0c2d4315cdce955e98c5a24a53f50c8ed2fd0
};

#endif // TRANSACTIONMANAGER_H
