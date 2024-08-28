import QtQuick 6.7
import QtQuick.Controls 6.7
import QtQuick.Layouts 6.7

ApplicationWindow {
    visible: true
    width: 600
    height: 800
    title: "Financial App"

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: Page4 {}
    }

}
