import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: page3

    property double selectedDay: 0
    property date selectedDate: new Date()
    property bool readyData: true

    ListModel {
        id: incomeCategories
        ListElement { text: "Investments" }
        ListElement { text: "Government Payments" }
        ListElement { text: "Salary" }
    }

    ListModel {
        id: spendCategories
        ListElement { text: "Entertainment" }
        ListElement { text: "Food" }
        ListElement { text: "Giving" }
        ListElement { text: "Housing" }
        ListElement { text: "Insurance" }
        ListElement { text: "Medical" }
        ListElement { text: "Personal" }
        ListElement { text: "Retirement" }
        ListElement { text: "Transportation" }
        ListElement { text: "Utilities" }
    }

    Text {
        id: pageTitle
        text: "Add a transaction"
        y: 100
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 30
    }

    Grid {
        id: form
        x : 40
        y: pageTitle.y + pageTitle.height + 40
        width: parent.width - x
        height: parent.height - y
        columns: 2
        columnSpacing: 20
        rowSpacing: 20

        Text {
            id: typeLabel
            text: "Type"
        }
        Row {
            spacing: 10
            RadioButton {
                id: spendTypeButton
                checked: true
                text: qsTr("Spend")
            }
            RadioButton {
                text: qsTr("Income")
            }
        }

        Text {
            id: categoryLabel
            text: "Category"
        }
        ComboBox {
            id: categoryInput
            model: spendTypeButton.checked === true ? spendCategories : incomeCategories
        }

        Text {
            id: amountLabel
            text: "Amount"
        }
        TextField {
            id: amountInput
            placeholderText: qsTr("0,00")
            validator: RegularExpressionValidator { regularExpression: /(\d{1,9})([.]\d{1,2})?$/ }
        }

        Text {
            id: dateLabel
            text: "Date"
        }
        ColumnLayout {
            Text {
                text: Qt.formatDateTime(gridCalendar.year + "-" + (gridCalendar.month + 1).toString().padStart(2, "0") + "-01", "MMMM yyyy")
            }

            DayOfWeekRow {
                locale: gridCalendar.locale
                Layout.fillWidth: true
            }

            MonthGrid {
                id: gridCalendar
                month: Calendar.August
                year: 2024
                locale: Qt.locale("en_US")
                Layout.fillWidth: true
                delegate: Text {
                    opacity: month === gridCalendar.month ? 1 : 0.2
                    text: day
                    font: gridCalendar.font
                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: -5
                        radius: 25
                        color: "blue"
                        opacity: 0.2
                        visible: selectedDay === date.getTime()
                    }
                }

                onClicked: (date) => {
                    selectedDate = date
                    selectedDay = date.getTime()
                }
            }
        }

        Button {
            id: validateButton
            text: "Validate"
            onClicked: {
                resultText.text = ""
                resultText.color = "red";
                readyData = true

                if (amountInput.text === "") {
                    resultText.text = "need amount"
                    readyData = false
                } else {
                    // fix the end of the number format if necessary
                    if (!amountInput.text.match(/[.]/)) {
                        amountInput.text += ".0"
                    } else if (!amountInput.text.match(/[.]\d+$/)) {
                        amountInput.text += "0"
                    }
                }

                if (selectedDay === 0) {
                    resultText.text = (resultText.text.length === 0) ? "need date" : "need amount and date"
                    readyData = false;
                }

                if (readyData) {
                    // TODO : database insert
                    resultText.color = "green";
                    resultText.text = "database insert : "
                            + (spendTypeButton.checked === true ? "Spend" : "Income") + ", "
                            + categoryInput.currentText  + ", "
                            + amountInput.text + ", "
                            + selectedDate.toISOString()
                }
            }
        }

        Text {
            id: resultText
            text: ""
            color: "red"
        }
    }
}
