import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
    // Define the background and content of your OnlineMap.qml here

    // Use a property or logic to show/hide the button
    Rectangle {
        height: 40 // Reduced height
        width: 150 // Reduced width
        anchors.left: parent.left // Align to the left
        anchors.bottom: parent.bottom // Align to the bottom
        anchors.margins: 20 // Margin from the bottom and left
        radius: 15 // Slightly less rounding
        color: "blue" // Change button color to blue

        Text {
            id: text1
            text: qsTr("Back")
            anchors.centerIn: parent
            color: "white" // Change text color to white
            font.bold: true // Make the text bold
            font.pointSize: 12 // Set font size to be smaller
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                loader.push("qrc:/main.qml")
            }
        }
    }
}
