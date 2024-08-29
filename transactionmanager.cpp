#include "transactionmanager.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlRecord>
#include <QDebug>

TransactionManager::TransactionManager(QObject *parent) : QObject(parent) {
    setupDatabase();
}

TransactionManager::~TransactionManager() {
    m_db.close();
}

void TransactionManager::setupDatabase() {
    m_db = QSqlDatabase::addDatabase("QSQLITE");
    m_db.setDatabaseName("transactionss.db");

    if (!m_db.open()) {
        qWarning() << "Error: connection with database failed";
    } else {
        qDebug() << "Database: connection established";
    }

    QSqlQuery query;
    query.exec("CREATE TABLE IF NOT EXISTS transactions (id INTEGER PRIMARY KEY, type TEXT, amount TEXT, date TEXT)");
}

void TransactionManager::loadTransactions() {
    m_transactions.clear();

    QSqlQuery query("SELECT type, amount, date FROM transactions");
    while (query.next()) {
        Transaction *transaction = new Transaction(this);
        transaction->setType(query.value(0).toString());
        transaction->setAmount(query.value(1).toDouble());  // Convert QString to double
        transaction->setDate(query.value(2).toString());
        m_transactions.append(transaction);
    }
    emit transactionsChanged();
}
    void TransactionManager::populateInitialData() {
        QSqlQuery query;

        // List of transactions to be inserted
        QList<QVariantList> transactions = {
            {"Income", "41", "12-12-2024"},
            {"Income", "122", "10-12-2024"},
            {"Income", "67", "11-12-2024"},
            {"Income", "41", "12-12-2020"},
            {"Spend", "44", "12-12-2024"},
            {"Spend", "12", "01-12-2023"},
            {"Spend", "03", "05-12-2022"}
        };

        // Insert transactions into the database
        foreach (const QVariantList &transaction, transactions) {
            query.prepare("INSERT INTO transactions (type, amount, date) VALUES (?, ?, ?)");
            query.addBindValue(transaction[0].toString());
            query.addBindValue(transaction[1].toString());
            query.addBindValue(transaction[2].toString());
            if (!query.exec()) {
                qWarning() << "Failed to insert transaction:" << query.lastError();
            }
        }

        // Load the transactions to refresh the model
        loadTransactions();
}
