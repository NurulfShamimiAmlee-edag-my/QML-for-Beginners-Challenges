import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {

    // TODO: change the size to ensure it forms the standard business card ratio of approx 1:1.586
    // HINT: you may wish to use a binding
    id: root

    width: 480
    height: 302

    visible: true
    title: qsTr("Business Card")

    component ContactInfo: QtObject {

        // This is a ContactInfo object which provides the properties to fill in.
        // You can create as many instances of this as you like with different property values.

        // show these properties all the time:
        property string name
        property url photo

        // Basic Info properties:
        property string occupation
        property string company

        // Detailed Info properties:
        property string address
        property string country
        property string phone
        property string email
        property url webSite
    }

    ContactInfo {
        id: myContactInfo

        // this is one example instance of a ContactInfo inline Component
        // showing how the properties are populated.

        name: "Your Name"
        photo: Qt.resolvedUrl("IDPhoto.png")
        occupation: "QML Enthusiast"
        company: "Indie Soft"
        address: "Candy Cane Lane"
        country: "North Pole"
        phone: "+01 2345 567 890"
        email: "email@server.com"
        webSite: Qt.url("https://www.qt.io")
    }

    /* Your solution should contain these key features:

        - A Text element for each of the ContactInfo properties.
        - The name and photo image should be shown all the time.
        - These should be grouped into two categories "Basic Info" and "Details".
        - Create a button using a MouseArea or TapHandler that can be used to
          toggle between showing the two categories of information.
        - Use a larger font size for the name
    */

    Rectangle
    {
        anchors.fill: parent
        anchors.margins: 10
        border.color: "black"
        border.width: 2
        radius: 10

        Row
        {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 70
            Column
            {
                // anchors.left: parent
                spacing: 10
                Text {
                    id: myName
                    text: myContactInfo.name
                    font.bold: true
                    font.pixelSize: 36
                }

                Text {
                    id: myCompany
                    text: myButton.checked ? myContactInfo.occupation : myContactInfo.company
                    font.pixelSize: 24
                }

                Text {
                    id: myCountry
                    text: myButton.checked ? myContactInfo.address : myContactInfo.country
                    font.pixelSize: 15
                }

                Text {
                    id: myPhoneNumber
                    text: myButton.checked ? " " : myContactInfo.phone
                }

                Text {
                    id: myEmail
                    text: myButton.checked ? " " : myContactInfo.email
                }

                Text {
                    id: myWebsite
                    text: myButton.checked ? " " : qsTr(myContactInfo.webSite)

                }


                Rectangle
                {
                    id: justASpacer
                    height: 25
                    width: 100
                }

                Rectangle
                {
                    id: myButton
                    signal clicked
                    property bool checkable:  true
                    property bool checked: false

                    height: 35
                    width: 100

                    // anchors.bottom: parent.bottom

                    border.color: "black"
                    color: myButton.checked ? "black" : "white"
                    radius:  25

                    TapHandler
                    {
                        id: myTapHandler
                        gesturePolicy: TapHandler.WithinBounds
                        onTapped: {
                            // toggle the checked property of
                            // the button
                            if(myButton.checkable) {
                                myButton.checked = !myButton.checked
                            }

                            // emit the button's clicked signal
                            // in case someone handles it
                            myButton.clicked()
                        }
                    }

                    Text
                    {
                        id: myButtonLabel
                        text: "Details"
                        color: myButton.checked? "white" : "black"
                        font.bold: true
                        font.pixelSize: 10
                        anchors.centerIn: parent

                    }

                }

            }

            Rectangle
            {
                id: myImageRect

                // anchors.right: parent.right
                anchors.margins: 5
                width: root.width * 0.3
                height: root.height *  0.5

                border.color: "black"
                border.width: 2
                radius: 3


                Image {
                    id: myImage

                    source: myContactInfo.photo
                    anchors.centerIn: parent
                    // anchors.margins: 10
                    // scale: 0.5

                    width: myImageRect.width * 0.95
                    height: myImageRect.height * 0.95
                    fillMode: Image.PreserveAspectFit
                }
            }
        }
    }

}
