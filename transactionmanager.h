#ifndef TRANSACTIONMANAGER_H
#define TRANSACTIONMANAGER_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlRecord>
#include <QStringList>

class TransactionManager : public QObject {
    Q_OBJECT
    Q_PROPERTY(QStringList peopleModel READ peopleModel NOTIFY peopleModelChanged)

public:
    explicit TransactionManager(QObject *parent = nullptr);
    ~TransactionManager();

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
};

#endif // TRANSACTIONMANAGER_H
