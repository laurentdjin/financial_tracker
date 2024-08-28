import QtQuick 6.7
import QtQuick.Controls 6.7


Item {
    id: page2
    property double soldeTotal: 5000.0
    property double totalRevenus: 10000.0
    property double totalDepenses: 5000.0

    Column {
        spacing: 50
        anchors.centerIn: parent

        Text {
            text: "Résumé financier"
            font.pixelSize: 40
        }

        // Affichage du solde total
        Text {
            text: "Solde Total: " + soldeTotal + " €"
            font.pixelSize: 20
            color: "teal"
        }

        // Affichage du total des revenus
        Text {
            text: "Total Revenus: " + totalRevenus + " €"
            font.pixelSize: 20
            color: "dodgerblue"
        }

        // Affichage du total des dépenses
        Text {
            text: "Total Dépenses: " + totalDepenses + " €"
            font.pixelSize: 20
            color: "crimson"
        }

        Button {
            text: "Ajouter au solde"
            onClicked: {
                page2.soldeTotal += 1000
            }
        }

        Button {
            text: "Retour à la Page 1"
            onClicked: stackView.pop()
        }
    }
}
