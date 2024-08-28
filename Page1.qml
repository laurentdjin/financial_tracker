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

                    onClicked: {
                        if (user_text.text !== "" && login_text.text !== "") {
                            if (dbManager.checkCredentials(user_text.text, login_text.text)) {
                                stackView.push(Qt.resolvedUrl("Page2.qml"))
                            } else {
                                console.log("Identifiants incorrects.");
                            }
                        } else {
                            console.log("Veuillez entrer un UserName et un Mot de Passe.");
                        }
                    }


                }

                Button {
                    text: "Nouveau Utilisateur"
                    font.pixelSize: 15
                        onClicked: {
                            if (user_text.text !== "" && login_text.text !== "") {
                                dbManager.insertData(user_text.text, login_text.text)
                                stackView.push(Qt.resolvedUrl("Page2.qml"))
                            } else {
                                console.log("Veuillez entrer un UserName et un Mot de Passe.")
                            }
                        }
                }


            }

            Row{

                spacing: 5
                anchors.horizontalCenter: parent.horizontalCenter

                Button {
                    text: "Vider la base de données"
                    onClicked: {
                        dbManager.dropTable()
                        dbManager.clearDatabase()
                    }
                }

                ListView {
                    width: 150
                    height: 150
                    model: dbManager.peopleModel  // Liaison directe avec la propriété exposée

                    delegate: Text {
                        text: modelData
                        font.pointSize: 15
                    }
                }
            }
        }
    }
}
