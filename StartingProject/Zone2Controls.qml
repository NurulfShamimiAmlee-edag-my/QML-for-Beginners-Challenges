import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Pane {

    padding: 10

    background: Rectangle {
        color: "white"
        opacity: 0.65

    }

    readonly property real zone2Subtotal: pilauRiceAmount.value + alooGhobiAmount.value + ahjiBhajiAmount.value + garlicNaanAmount.value + keemaNaanAmount.value + naanAtAllmount.value + tipAmount.value

    ColumnLayout {

        spacing: 5

        anchors.fill: parent

        Label {
            id: sidesLabel
            text: qsTr("Sides")
            font.pixelSize: 18
        }

        RowLayout {

            spacing: 5

            Label {
                text: qsTr("Pilau Rice: $%1").arg(pilauRiceAmount.value)
            }

            SpinBox {
                id: pilauRiceAmount
                from: 0
                to: 10
                value: 8
            }
        }

        RowLayout {

            spacing: 5

            Label {
                text: qsTr("Aloo Ghobi: $%1").arg(alooGhobiAmount.value)
            }

            SpinBox {
                id: alooGhobiAmount
                from: 0
                to: 10
                value: 8
            }
        }

        RowLayout {

            spacing: 5

            Label {
                text: qsTr("Ahji Bhaji: $%1").arg(ahjiBhajiAmount.value)
            }

            SpinBox {
                id: ahjiBhajiAmount
                from: 0
                to: 10
                value: 8
            }
        }

        Label {
            text: "Breads"
            font.pixelSize: 18
        }

        RowLayout {

            spacing: 5

            Label {
                text: qsTr("Garlic Naan: $%1").arg(garlicNaanAmount.value)
            }

            SpinBox {
                id: garlicNaanAmount
                from: 0
                to: 10
                value: 8
            }
        }

        RowLayout {

            spacing: 5

            Label {
                text: qsTr("Keema Naan: $%1").arg(keemaNaanAmount.value)
            }

            SpinBox {
                id: keemaNaanAmount
                from: 0
                to: 10
                value: 8
            }
        }

        RowLayout {

            spacing: 5

            Label {
                text: qsTr("Naan at all : $%1").arg(naanAtAllmount.value)
            }

            SpinBox {
                id: naanAtAllmount
                from: 0
                to: 10
                value: 8
            }
        }

        Label {
            text: "Dining Options"
            font.pixelSize: 18
        }

        RowLayout {
            spacing: 5

            RadioButton {
                id: eatInRadioButton
                text: qsTr("Eat In")
            }

            RadioButton {
                id: takeAwayButton
                text: qsTr("Take away")
            }
        }

        Label {
            text: "Tip Amount"
            font.pixelSize: 18
        }

        RowLayout {
            spacing: 5

            Slider {
                id: tipAmount
                from: 0
                to: 100

                stepSize: 1

                value: 20
            }

            Label {
                text: qsTr("$%1").arg(tipAmount.value)
            }
        }

    }

}
