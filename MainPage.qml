import QtQuick 6.7
import QtQuick.Controls 6.7
import QtQuick.Layouts 6.7

ApplicationWindow {
    visible: true
    width: 600
    height: 800
    title: "Financial App"

    TabBar {
        id: bar
        width: parent.width
        TabButton {
            text: qsTr("Home/Resume")
        }
        TabButton {
            text: qsTr("Add transaction")
        }
        TabButton {
            text: qsTr("Transaction history")
        }
    }

    StackLayout {
        width: parent.width
        currentIndex: bar.currentIndex
        Page2 {}
        Page3 {}
        Page4 {}
    }
}
