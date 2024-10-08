#include "transactionmanager.h"
#include <QDebug>

TransactionManager::TransactionManager(QObject *parent)
    : QObject(parent) {
    m_db = QSqlDatabase::addDatabase("QSQLITE");
    m_db.setDatabaseName("people.db");

    if (!m_db.open()) {
        qWarning() << "Erreur lors de l'ouverture de la base de données:" << m_db.lastError().text();
    } else {
        qDebug() << "Base de données ouverte avec succès.";
        updateModel();  // Initialiser le modèle lorsque la base de données est ouverte
    }
}

TransactionManager::~TransactionManager() {
    m_db.close();
}

bool TransactionManager::createTable() {
    QSqlQuery query;
    QString createTable = "CREATE TABLE IF NOT EXISTS people (id INTEGER PRIMARY KEY, username TEXT, password TEXT)";
    if (!query.exec(createTable)) {
        qWarning() << "Erreur lors de la création de la table:" << query.lastError().text();
        return false;
    } else {
        qDebug() << "Table 'people' créée ou déjà existante.";
    }
    return true;
}

bool TransactionManager::insertData(const QString &username, const QString &password) {
    QSqlQuery query;
    query.prepare("INSERT INTO people (username, password) VALUES (:username, :password)");
    query.bindValue(":username", username);
    query.bindValue(":password", password);

    if (!query.exec()) {
        qWarning() << "Erreur lors de l'insertion des données:" << query.lastError().text();
        qWarning() << "Requête exécutée:" << query.executedQuery();
        qWarning() << "debug : " << username + " " << password;
        return false;
    }

    else {
        qDebug() << "Données insérées avec succès:" << username << password;
        updateModel();  // Mettre à jour le modèle après l'insertion des données
    }

    return true;
}

bool TransactionManager::clearDatabase() {
    QSqlQuery query;
    QString clearTable = "DELETE FROM people";
    if (!query.exec(clearTable)) {
        qWarning() << "Erreur lors du vidage de la table:" << query.lastError().text();
        return false;
    }
    else {
        qDebug() << "Table 'people' vidée avec succès.";
        updateModel();  // Mettre à jour le modèle après avoir vidé la base de données
    }
    return true;
}

bool TransactionManager::dropTable() {
    QSqlQuery query;
    QString dropTable = "DROP TABLE IF EXISTS people";
    if (!query.exec(dropTable)) {
        qWarning() << "Erreur lors de la suppression de la table:" << query.lastError().text();
        return false;
    } else {
        qDebug() << "Table 'people' supprimée avec succès.";
        // Recréer la table si nécessaire
        createTable();  // Appel à createTable() pour recréer la table
    }
    return true;
}


QStringList TransactionManager::peopleModel() {
    return m_peopleModel;
}

void TransactionManager::updateModel() {
    m_peopleModel.clear();
    QSqlQuery query("SELECT username, password FROM people");
    while (query.next()) {
        QString person = (query.value(0).toString()) + " - " + (query.value(1).toString());
        m_peopleModel << person;
    }
    emit peopleModelChanged();  // Notifier QML que le modèle a changé
}

bool TransactionManager::checkCredentials(const QString &username, const QString &password) {
    QSqlQuery query;
    query.prepare("SELECT* FROM people WHERE username = :username AND password = :password");
    query.bindValue(":username", username);
    query.bindValue(":password", password);
    if (!query.exec()) {
        qWarning() << "Erreur lors de la vérification des identifiants:" << query.lastError().text();
        return false;
    }
    query.next();
    return query.value(0).toInt() > 0;  // Retourne true si le compte existe, false sinon
}
