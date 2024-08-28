#ifndef TRANSACTION_H
#define TRANSACTION_H

#include <QObject>
#include <QString>

class Transaction : public QObject {
    Q_OBJECT

    // Properties usable on QML
    Q_PROPERTY(double amount READ amount WRITE setAmount NOTIFY amountChanged)
    Q_PROPERTY(QString type READ type WRITE setType NOTIFY typeChanged)
    Q_PROPERTY(QString category READ category WRITE setCategory NOTIFY categoryChanged)
    Q_PROPERTY(QString date READ date WRITE setDate NOTIFY dateChanged)

public:
    explicit Transaction(QObject* parent = nullptr)
        : QObject(parent), m_amount(0.0), m_type("Unknown"), m_category("Unknown"), m_date("1970-01-01") {}

    // Getters for properties
    double amount() const { return m_amount; }
    QString type() const { return m_type; }
    QString category() const { return m_category; }
    QString date() const { return m_date; }

    // Setters for properties
    void setAmount(double amount) {
        if (m_amount != amount) {
            m_amount = amount;
            emit amountChanged(); // Emit signal when 'amount' change
        }
    }

    void setType(const QString& type) {
        if (m_type != type) {
            m_type = type;
            emit typeChanged(); // Emit signal when 'type' change
        }
    }

    void setCategory(const QString& category) {
        if (m_category != category) {
            m_category = category;
            emit categoryChanged(); // Emit signal when 'category' change
        }
    }

    void setDate(const QString& date) {
        if (m_date != date) {
            m_date = date;
            emit dateChanged(); // Emit signal when 'date' change
        }
    }

signals:
    // Signals emitted when value of these properties change
    void amountChanged();
    void typeChanged();
    void categoryChanged();
    void dateChanged();

private:
    double m_amount;
    QString m_type;
    QString m_category;
    QString m_date;
};


#endif // TRANSACTION_H
