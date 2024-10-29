import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: upperBar
    color: "white"
    height: parent.height / 15
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top

    Image {
        id: kemalaklogo
        anchors {
            left: parent.left
            leftMargin: 20 // Adjusted margin to position the first logo
            verticalCenter: parent.verticalCenter
        }
        height: parent.height * 0.9 // Increased size of the first logo
        fillMode: Image.PreserveAspectFit
        source: "qrc:/ui/assests/kemalak_logo.png"
    }

    // Image {
    //     id: airportLogo
    //     anchors {
    //         left: kemalaklogo.right // Anchor to the right of the first logo
    //         leftMargin: 5 // Margin between the two logos
    //         verticalCenter: parent.verticalCenter // Center vertically
    //     }
    //     height: parent.height * 0.9 // Increased size of the second logo
    //     fillMode: Image.PreserveAspectFit
    //     source: "qrc:/ui/assests/airport.png" // Replace with the source of your second logo
    // }

    // Image {
    //     id: mapLogo
    //     anchors {
    //         left: flightLogo.right // Anchor to the right of the flight logo
    //         leftMargin: 5 // Margin between the two logos
    //         verticalCenter: parent.verticalCenter // Center vertically
    //     }
    //     height: parent.height * 0.9 // Increased size of the third logo
    //     fillMode: Image.PreserveAspectFit
    //     source: "qrc:/ui/assests/map.png" // Replace with the source of your third logo
    // }

    // Image {
    //     id: helpLogo
    //     anchors {
    //         left: mapLogo.right // Anchor to the right of the map logo
    //         leftMargin: 5 // Margin between the two logos
    //         verticalCenter: parent.verticalCenter // Center vertically
    //     }
    //     height: parent.height * 0.9 // Increased size of the fourth logo
    //     fillMode: Image.PreserveAspectFit
    //     source: "qrc:/ui/assests/help.png" // Replace with the source of your fourth logo
    // }

    // Image {
    //     id: globeLogo
    //     anchors {
    //         left: helpLogo.right // Anchor to the right of the help logo
    //         leftMargin: 5 // Margin between the two logos
    //         verticalCenter: parent.verticalCenter // Center vertically
    //     }
    //     height: parent.height * 0.9 // Increased size of the fifth logo
    //     fillMode: Image.PreserveAspectFit
    //     source: "qrc:/ui/assests/globe.jpeg" // Replace with the source of your fifth logo
    // }
}
