#ifndef TRANSACTIONMANAGER_H
#define TRANSACTIONMANAGER_H

#include <QObject>
#include <QList>
#include <QSqlDatabase>
#include "transaction.h"

class TransactionManager : public QObject {
    Q_OBJECT
    Q_PROPERTY(QList<QObject*> transactions READ transactions NOTIFY transactionsChanged)

public:
    explicit TransactionManager(QObject *parent = nullptr);
    ~TransactionManager();

    Q_INVOKABLE void loadTransactions(); // Fetch transactions from the database

    Q_INVOKABLE void populateInitialData(); // Populate the database with initial data

    QList<QObject*> transactions() const { return m_transactions; }

signals:
    void transactionsChanged();

private:
    QSqlDatabase m_db;
    QList<QObject*> m_transactions;
    void setupDatabase();
};

#endif // TRANSACTIONMANAGER_H
