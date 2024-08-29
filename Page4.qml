import QtQuick 6.7
import QtQuick.Controls 6.7
import QtQuick.Layouts 6.7

Item {
    width: 600
    height: 800

    Rectangle {
        anchors.fill: parent
        color: "lightblue"

        ColumnLayout {
            id: cln
            spacing: 20
            anchors.top: parent.top
            anchors.margins: 10

            // Title Text
            Text {
                text: "Historique"
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 20
            }

            // Row with ComboBox and Clean Button
            Row {
                spacing: 10
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.leftMargin: 10
                anchors.rightMargin: 10

                // ComboBox for selecting filter type
                ComboBox {
                    id: filterComboBox
                    model: ["Show ALL", "Income", "Spend"]
                    currentIndex: 0

                    onCurrentIndexChanged: {
                        switch (currentIndex) {
                            case 0:
                                listView.filterType = "all";
                                rowA.visible=true;
                                break;
                            case 1:
                                listView.filterType = "Income";
                                rowA.visible=true;
                                break;
                            case 2:
                                listView.filterType = "Spend";
                                rowA.visible=true;
                                break;
                        }
                        listView.visible = true;
                        listView.currentIndex = 0; // Ensure list starts at the top
                    }
                }

                // TextField for date input
                TextField {
                    id: dateField
                    placeholderText: "Enter date (jj-mm-yy)"
                    width: 150
                }

                // Button to search by date
                Button {
                    text: "Search"
                    onClicked: {
                        listView.dateFilter = dateField.text;
                        listView.visible = true;
                        listView.currentIndex = 0; // Ensure list starts at the top
                        rowA.visible=true
                    }
                }

                Button {
                    text: "Clean"
                    onClicked: listView.visible = false // Hide the ListView
                }
            }
            Row {
                id:rowA
                // anchors.fill: parent
                // spacing: 10
                // padding: 5
                spacing: 10
                //anchors.horizontalCenter: parent.horizontalCenter
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                visible: false

                Text {
                    text: "Type"
                    width: 100
                    font.pointSize: 16
                    horizontalAlignment: Text.AlignLeft
                }

                Text {
                    text: "Amount"
                    width: 100
                    font.pointSize: 16
                    horizontalAlignment: Text.AlignCenter
                }

                Text {
                    text: "Date"
                    width: 150
                    font.pointSize: 16
                    horizontalAlignment: Text.AlignRight
                }
            }

            // ListView to display model data
            ListView {
                id: listView
                width: 600
                height: 400

                // Property to filter the list based on type
                property string filterType: ""
                property string dateFilter: ""
                model:transactionManager.transactions
                // model: ListModel {
                //     ListElement { type: "Income"; amount: "44"; date: "12-12-2024" }
                //     ListElement { type: "Income"; amount: "55"; date: "12-12-2024" }
                //     ListElement { type: "Income"; amount: "66"; date: "12-12-2024" }
                //     ListElement { type: "Income"; amount: "66"; date: "12-12-2020" }
                //     ListElement { type: "Spend"; amount: "44"; date: "12-12-2024" }
                //     ListElement { type: "Spend"; amount: "55"; date: "12-12-2024" }
                //     ListElement { type: "Spend"; amount: "66"; date: "12-12-2024" }
                // }

                // delegate: Rectangle {
                //     width: parent.width
                //     height: 30
                //     //color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
                //       color: model.type === "Income" ? "lightgreen" : "lightcoral" //

                //     visible: ((listView.filterType === "all" || model.type === listView.filterType) && listView.dateFilter === "") ||
                //              ( model.date === listView.dateFilter)

                //     Text {
                //         text: "Transaction Type: " + model.type + " Amount: " + model.amount + " $ " + " Date: " + model.date
                //         anchors.centerIn: parent
                //         font.pointSize: 16
                //     }
                // }

                delegate: Rectangle {
                    width: parent.width
                    height: 40
                    color: model.type === "Income" ? "lightgreen" : "lightcoral"
                        visible: ((listView.filterType === "all" || model.type === listView.filterType) && listView.dateFilter === "") ||
                                 ( model.date === listView.dateFilter)

                    Row {
                        anchors.fill: parent
                        spacing: 10
                        padding: 5

                        Text {
                            text: model.type
                            width: 100
                            font.pointSize: 16
                            horizontalAlignment: Text.AlignLeft
                        }

                        Text {
                            text: model.amount + " $"
                            width: 100
                            font.pointSize: 16
                            horizontalAlignment: Text.AlignCenter
                        }

                        Text {
                            text: model.date
                            width: 150
                            font.pointSize: 16
                            horizontalAlignment: Text.AlignRight
                        }
                    }
                }

            }
        }
    }
}
