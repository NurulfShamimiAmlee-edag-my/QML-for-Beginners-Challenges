import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Pane {

    padding: 10

    background: Rectangle {
        color: "white"
        opacity: 0.65

    }

    readonly property real zone1Subtotal: onionBhajiAmount.value + meatSamosaAmount.value + nargisKebabAmount.value + paneerTikkaAmount.value + lambBhunaAmount.value + murghTikkaAmount.value

    ColumnLayout {

        spacing: 5
        anchors.fill: parent

        Label {
            id: startersLabel
            text: qsTr("Starters")
            font.pixelSize: 18
        }

        RowLayout {

            spacing: 5

            Label {
                text: qsTr("Onion Bhaji : $%1").arg(onionBhajiAmount.value)
            }

            SpinBox {
                id: onionBhajiAmount
                from: 0
                to: 10
                value: 8
            }
        }

        RowLayout {
            spacing:5

            Label {
                text: qsTr("Meat Samosa: $%1").arg(meatSamosaAmount.value)
            }

            SpinBox {
                id: meatSamosaAmount
                from: 0
                to: 10
                value: 8
            }
        }

        RowLayout {
            spacing:5

            Label {
                text: qsTr("Nargis Kebab: $%1").arg(nargisKebabAmount.value)
            }

            SpinBox {
                id: nargisKebabAmount
                from: 0
                to: 10
                value: 8
            }
        }

        Label {
            id: mainsLabel
            text: qsTr("Mains")
            font.pixelSize: 18
        }

        RowLayout {
            spacing:5

            Label {
                text: qsTr("Paneer Tikka: $%1").arg(paneerTikkaAmount.value)
            }

            SpinBox {
                id: paneerTikkaAmount
                from: 0
                to: 10
                value: 8
            }
        }

        RowLayout {
            spacing:5

            Label {
                text: qsTr("Lamb Bhuna: $%1").arg(lambBhunaAmount.value)
            }

            SpinBox {
                id: lambBhunaAmount
                from: 0
                to: 10
                value: 8
            }
        }

        RowLayout {
            spacing:5

            Label {
                text: qsTr("Murgh Tikka: $%1").arg(murghTikkaAmount.value)
            }

            SpinBox {
                id: murghTikkaAmount
                from: 0
                to: 10
                value: 8
            }
        }


        Label {
            text: qsTr("Spice Level")
            font.pixelSize: 18
        }

        RowLayout {
            spacing: 5

            Image {
                source: Qt.resolvedUrl("images/light/mild.svg")
                Layout.alignment: Qt.AlignBottom
            }

            Dial {
                id: spiceLevelDial

                from: 0
                to: 100

                value: 0

                stepSize: 1

                snapMode: Dial.SnapAlways
            }

            Image {
                source: Qt.resolvedUrl("images/light/very_hot.svg")
                Layout.alignment: Qt.AlignBottom
            }

        }

    }

}
