import QtQuick 6.7
import QtQuick.Controls 6.7
import QtQuick.Layouts 6.7

Item {
    width: 800
    height: 800

    Rectangle {
        anchors.fill: parent
        color: "lightblue"

    Column {
        spacing: 40
        anchors.centerIn: parent

        /**
        @brief Input area for user User Name
        */
        TextField {
            id: user_text
            wrapMode: TextInput.Wrap
            width: 300
            placeholderText: "Veuillez saisir votre User Name"
            font.pixelSize: 20
        }

         /**
         @brief Input area for user password
        */
        TextField {
            id: login_text
            wrapMode: TextInput.Wrap
            placeholderText: "Veuillez saisir votre Mot de passe"
            width: 300
            echoMode: TextInput.Password
            font {
                pixelSize: 20
            }

        }

        Row{

            spacing: 5
            anchors.horizontalCenter: parent.horizontalCenter

            Button {
                text: "Se Connecter"
                font.pixelSize: 15
                onClicked: stackView.push(Qt.resolvedUrl("Page2.qml"))
            }

            Button {
                text: "Nouveau Utilisateur"
                font.pixelSize: 15
                onClicked: stackView.push(Qt.resolvedUrl("Page2.qml"))
            }
        }
    }
    }
}
