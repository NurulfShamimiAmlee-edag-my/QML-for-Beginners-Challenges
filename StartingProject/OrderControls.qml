import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Page {

    id: root

    // background: Rectangle {
    //     color: "red"
    // }

    background: null

    readonly property real totalOrderFoodCost: zone1.zone1Subtotal + zone2.zone2Subtotal

    header:  Pane {

        background: Rectangle {
            color: "white"
            opacity: 0.8
        }

        Label {

            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
            padding: 10
            text: qsTr("My Cottage Restaurant")
            font.pixelSize: 24
            Layout.fillWidth: true

        }
    }

    palette {
        dark: "black"
        window: "white"
        windowText: "black"
    }

    RowLayout {
        anchors.fill: parent
        spacing: 5

        Zone1Controls {
            id: zone1

            Layout.fillHeight: true
            Layout.fillWidth: true

        }

        Zone2Controls {
            id: zone2

            Layout.fillHeight: true
            Layout.fillWidth: true

        }

    }


    footer: Pane {

        background: Rectangle {
            color: "white"
            opacity: 0.8
        }

        RowLayout {
                anchors.fill: parent

                Label {
                    text: qsTr("Total Order Cost: $%1 ").arg(root.totalOrderFoodCost)
                    font.pixelSize: 24
                    Layout.fillWidth: true
                }

                Button{
                    text: qsTr("Order Now")
                    enabled: root.totalOrderFoodCost > 0
                }
        }
    }

}
