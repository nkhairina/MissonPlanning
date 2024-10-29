import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "ui/UpperBar"
import "ui/RightScreen"
import "ui/LeftScreen"

Window {
    width: 1280
    height: 720
    visible: true
    title: qsTr("Flight Planning and Tracking System")

    LeftScreen {
        id: leftScreen
    }

    RightScreen {
        id: rightScreen
    }

    UpperBar {
        id: upperBar
    }

    StackView {
        id: loader
        anchors.fill: parent
    }

    Rectangle {
        id: backButton
        height: 40
        width: 150
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 20
        radius: 15
        color: "blue"

        Text {
            id: text1
            text: qsTr("Next")
            anchors.centerIn: parent
            color: "white"
            font.bold: true
            font.pointSize: 12
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                loader.push("qrc:/OnlineMap.qml")
                backButton.visible = false // Hide the button when navigating
            }
        }
    }
}
