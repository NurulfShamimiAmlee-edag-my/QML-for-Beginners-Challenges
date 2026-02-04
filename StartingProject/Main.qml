pragma ComponentBehavior: Bound
// for permitting access to window.themeColor
// from inside any component declarations in this file

import QtQuick

Window {
    id: window

    /* Your solution should contain these key features:

    - Add a Window with dimensions which resemble the kind of
      remote control shape you want

    - Using components from the Qt Quick module such as Text,
      Image, Rectangle and any other components you want to use
      in your design, construct your shape, colors and layout of
      the elements you need.

    - You should include a number of Buttons providing features
      such as Volume +/-, Mute, Channel +/-, Power on/off, and
      perhaps even some cursor arrows.

    - Add image resources to your project and use them in your
      design and try to show how the image URL might be changed
      using bindings inside a string template expression.

    - Add a font to your project and use a FontLoader to be able
      to use the font in your Text components.

    - Create re-usable items using inline components adding any
      "required" properties where necessary

    - Using bindings and signal handlers to connect your UI
      elements to the provided tvControl object (below) so that
      interacting with your Buttons for example, could change
      the visible, enabled, or color of some of the other
      elements based on the changed state of the tvControl
      object’s properties.

    */

    // Here we have chosen a reasonable shape for your
    // remote control, but feel free to design your own.
    width: 240
    height: 740
    visible: true
    color: "black"

    // the window provides a themeColor property which you
    // may use wherever you need to refer to the same color
    property color themeColor: "silver"

    /* Here are a few components you can use to get you going */

    component BorderGradient: Rectangle {
        id: borderGradientRectangle

        // BorderGradient:
        // A simple Rectangle with a 2-color gradient

        // We use the Rectangle's own color property as
        // the first gradient stop color (so we upgrade the
        // color property to a required property)
        property color color2: borderGradientRectangle.color.darker()

        color: window.themeColor

        gradient: Gradient {
            GradientStop {
                position: 0
                color: borderGradientRectangle.color
            }
            GradientStop {
                position: 1
                color: borderGradientRectangle.color2
            }
        }
    }

    component DoubleBorderGradient: BorderGradient {
        id: doubleBorderGradient

        // DoubleBorderGradient:
        // A BorderGradient with another one nested inside
        // with a specified innerMargin

        property int innerMargin: 2

        BorderGradient {
            // inner gradient
            anchors {
                fill: parent
                margins: doubleBorderGradient.innerMargin
            }

            radius: doubleBorderGradient.radius - doubleBorderGradient.innerMargin

            // swap the colors around
            color: doubleBorderGradient.color2
            color2: doubleBorderGradient.color
        }
    }

    component Button: DoubleBorderGradient {
        id: button

        // Button:
        // A clickable DoubleBorderGradient with a useful
        // clicked signal and a pressed property alias

        readonly property alias pressed: tapHandler.pressed
        signal clicked

        implicitWidth: 100
        implicitHeight: 40

        radius: Math.min(width, height) / 2

        color: tapHandler.pressed ? window.themeColor : window.themeColor.darker()
        color2: tapHandler.pressed ? window.themeColor.darker() : window.themeColor

        TapHandler {
            id: tapHandler
            gesturePolicy: TapHandler.WithinBounds
            onTapped: button.clicked()
        }
    }

    component CircleButton: Button {
        id: circleButton

        // CircleButton:
        // A circular Button for convenience

        width: 200
        height: width // a circle

        // The CircleButton uses Item's containmentMask
        // property to return the boolean result of a
        // simplified test to check if the point is inside
        // the circle or not.
        containmentMask: QtObject {
            function contains(clickPoint: point) : bool {
                return (Math.pow(clickPoint.x - circleButton.radius, 2) +
                        Math.pow(clickPoint.y - circleButton.radius, 2))
                        < Math.pow(circleButton.radius, 2)
            }
        }
    }


    QtObject {
        id: tvControl

        // The tvControl object is provided for you to use as a
        // mock back-end providing a number of typical properties
        // and features you might find on a remote control.
        // There are even 5 channels with sample channelNames.

        property int channelNumber: 0
        readonly property string channelNumberString: `Channel ${channelNumber.toString().padStart(2,"0")}`
        readonly property string channelName: channelNames[channelNumber]

        // TV Features
        property bool closedCaptionsEnabled: true
        property bool hdrEnabled: true
        property bool castConnected: true
        property bool listening: false
        property bool muted: false
        property real volume: 0.75
        readonly property bool soundOn: !muted && volume > 0

        function incrementVolume() {
            volume = Math.min(1, volume + 0.1)
        }

        function decrementVolume() {
            volume = Math.max(0, volume - 0.1)
        }

        function incrementChannel() {
            channelNumber = Math.min(channelNames.length - 1, channelNumber + 1)
        }

        function decrementChannel() {
            channelNumber = Math.max(0, channelNumber - 1)
        }

        property list<string> channelNames: [
            "News Station",
            "Comedy Cable",
            "Eats and Beats",
            "Weather",
            "Cartoons",
            "Reality TV"
        ]
    }

    // Here we provide a suggested remote control background
    DoubleBorderGradient {
        id: remoteControlBackground

        anchors.fill: parent
        innerMargin: 8
        radius: 40
    }

    // As a demonstration of one of the Button types,
    // we add a power button.
    CircleButton {
        id: powerButton

        anchors {
            top: parent.top
            right: parent.right
            topMargin: 20
            rightMargin: 20
        }
        width: 40
        height: 40
        color: "darkred"

        onClicked: window.close()

        Image {
            id: powerButtonImage

            anchors.fill: parent
            anchors.margins: 10

            source: "images/power.svg"
        }
    }

    // LCD Screen
    DoubleBorderGradient {
        id: lcdScreen

        anchors {
            top: powerButton.bottom
            left: parent.left
            right: parent.right
            margins: 20

        }

        height: 100
        radius: 8
        color:  "#93AA4B"
        innerMargin: 1

        Item {
            id: lcdContenItem

            anchors{
               fill: parent
               margins: 10
            }

            opacity: 0.5

            Rectangle {
                id: volumeIndicator

                anchors {
                    top: parent.top
                    right: parent.right
                    bottom: parent.bottom
                }

                width: 12
                color: "transparent"
                border {
                    color: "black"
                    width: 2
                }

                Rectangle {
                    id: volumeValue

                    anchors.bottom: parent.bottom
                    color: "black"
                    width: volumeIndicator.width
                    height: volumeIndicator.height * tvControl.volume
                    opacity: tvControl.muted? 0.5 : 1
                }
            }

            Text {
                id: channelNumberText

                anchors {
                    top: parent.top
                    topMargin: -8
                    left: parent.left
                    right: volumeIndicator.left
                    rightMargin: 4
                }

                font {
                    pixelSize: 20
                }

                text: tvControl.channelNumberString
                color: "black"

            }

            Text {
                id: channelName

                anchors {
                    top: channelNumberText.bottom
                    topMargin: 5
                    left: parent.left
                    right: volumeIndicator.left
                    rightMargin: 4
                }

                font {
                    pixelSize: 16
                }

                text: tvControl.channelName
                color: "black"

            }

            Image {
                id: closedCaptionIcon

                anchors {
                    top: channelName.bottom
                    bottom: parent.bottom
                    left: parent.left
                    topMargin:  4
                    bottomMargin:4
                }

                width: 35
                height: width

                visible: tvControl.closedCaptionsEnabled

                source: "images/closed_caption.svg"

                fillMode: Image.PreserveAspectFit

            }

            Image {
                id: hdrIcon

                anchors {
                    top: channelName.bottom
                    bottom: parent.bottom
                    left: closedCaptionIcon.right
                    topMargin:  4
                    bottomMargin:4
                }

                width: 35
                height: width

                visible: tvControl.hdrEnabled

                source: "images/hdr_on.svg"

                fillMode: Image.PreserveAspectFit

            }

            Image {
                id: castIcon

                anchors {
                    top: channelName.bottom
                    bottom: parent.bottom
                    left: hdrIcon.right
                    topMargin:  4
                    bottomMargin:4
                }

                width: 35
                height: width

                visible: tvControl.castConnected

                source: "images/cast_connected.svg"

                fillMode: Image.PreserveAspectFit

            }

            Image {
                id: micIcon

                anchors {
                    top: channelName.bottom
                    bottom: parent.bottom
                    left: castIcon.right
                    topMargin:  4
                    bottomMargin:4
                }

                width: 35
                height: width

                source: "images/mic.svg"

                fillMode: Image.PreserveAspectFit

                visible: false

                Timer {
                    interval: 500
                    repeat: true
                    running: tvControl.listening
                    onTriggered: listeningIcon.visible = !listeningIcon.visible
                    triggeredOnStart: true
                    onRunningChanged: if(!running) listeningIcon.visible = false
                }

            }

            Image {
                id: muteIcon

                anchors {
                    bottom: parent.bottom
                    left: micIcon.right
                    leftMargin: -7
                }
                width: 35
                height: width
                source: Qt.resolvedUrl(`images/speaker${tvControl.soundOn ? "" : "_muted"}.svg`)
                fillMode: Image.PreserveAspectFit
            }

        }

    }

    Item {

        id: featureButtons

        anchors {
            top: lcdScreen.bottom
            topMargin: 25

        }

        CircleButton {
            id: closedCaptionButton

            anchors
            {
                left: parent.left
                margins: 20
            }

            width: 40
            height: width


            onClicked: tvControl.closedCaptionsEnabled = !tvControl.closedCaptionsEnabled

            Image {
                id: ccButtonIcon

                anchors{
                    centerIn: parent
                }

                width: closedCaptionButton.width * 0.5
                height: width

                source: "images/closed_caption_white.svg"
                fillMode: Image.PreserveAspectFit

            }

        }

        CircleButton {
            id: hdrButton

            anchors
            {
                left: closedCaptionButton.left
                leftMargin: 55
            }

            width: 40
            height: width


            onClicked: tvControl.hdrEnabled = !tvControl.hdrEnabled

            Image {
                id: hdrButtonIcon

                anchors{
                    centerIn: parent
                }

                width: hdrButton.width * 0.5
                height: width

                source: "images/hdr_on_white.svg"
                fillMode: Image.PreserveAspectFit

            }

        }

        CircleButton {
            id: castButton

            anchors
            {
                left: hdrButton.left
                leftMargin: 55
            }

            width: 40
            height: width


            onClicked: tvControl.castConnected = !tvControl.castConnected

            Image {
                id: castButtonIcon

                anchors{
                    centerIn: parent
                }

                width: castButton.width * 0.5
                height: width

                source: "images/cast_white.svg"
                fillMode: Image.PreserveAspectFit

            }

        }

        CircleButton {
            id: muteButton

            anchors
            {
                left: castButton.left
                leftMargin: 55
            }

            width: 40
            height: width


            onClicked: tvControl.muted = !tvControl.muted

            Image {
                id: muteButtonIcon

                anchors{
                    centerIn: parent
                }

                width: castButton.width * 0.5
                height: width

                source: "images/speaker_muted_white.svg"
                fillMode: Image.PreserveAspectFit

            }

        }

    }

    Item {
        id: playBackControl

        anchors {
            top: featureButtons.bottom
            topMargin: 20
            horizontalCenter: parent.horizontalCenter
        }

        width: 200
        height: 200

        CircleButton {

        }

    }

}



