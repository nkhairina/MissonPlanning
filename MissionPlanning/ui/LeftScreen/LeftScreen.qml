import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: leftScreen
    anchors {
        left: parent.left // tetapkan anchor kiri pada kiri screen
        right: rightScreen.left // tetapkaan anchor kanan pada kiri screen
        top: upperBar.bottom
        bottom: parent.bottom
    }
    width: rightScreen.width * 0.2 // lebar screen 20%
    color: "#f0f0f0" // background colour

    // Define the signal utk hantar isyarat coordinate
    signal markOnMapFromCoordinates(real x, real y, real latitude, real longitude)

    ListModel {
        id: rolesListModel // entry list untuk simpan coordinate
    }

    property int selectedItemIndex: -1 // Moved here

    Column {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10
        anchors.topMargin: 20

        // Radio buttons for input choice
        Column {
            spacing: 10

            RadioButton {
                id: pixelInputChoice
                text: "Input Pixel Coordinates"
                checked: true
                onClicked: {
                    pixelInputContainer.visible = true
                    geoInputContainer.visible = false
                }
            }

            RadioButton {
                id: geoInputChoice
                text: "Input Geo Coordinates"
                onClicked: {
                    pixelInputContainer.visible = false
                    geoInputContainer.visible = true
                }
            }
        }

        // Container for Pixel Input
        Column {
            id: pixelInputContainer
            spacing: 10

            TextField {
                id: xInput
                placeholderText: "Enter X Coordinate"
                width: 150
                font.pixelSize: 14
                inputMethodHints: Qt.ImhFormattedNumbersOnly
            }

            TextField {
                id: yInput
                placeholderText: "Enter Y Coordinate"
                width: 150
                font.pixelSize: 14
                inputMethodHints: Qt.ImhFormattedNumbersOnly
            }
        }

        // Container for Geo Input
        Column {
            id: geoInputContainer
            spacing: 10
            visible: false

            // Latitude Input
            Column {
                spacing: 5

                Text {
                    text: "Latitude"
                    font.bold: true
                }

                Row {
                    spacing: 5
                    TextField {
                        id: latDegreesInput
                        placeholderText: "Degrees (Lat)"
                        width: 50
                        font.pixelSize: 14
                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                    }

                    TextField {
                        id: latMinutesInput
                        placeholderText: "Minutes (Lat)"
                        width: 50
                        font.pixelSize: 14
                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                    }

                    TextField {
                        id: latSecondsInput
                        placeholderText: "Seconds (Lat)"
                        width: 50
                        font.pixelSize: 14
                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                    }

                    ComboBox {
                        id: latDirectionInput
                        width: 40
                        model: ["N", "S"]
                        currentIndex: 0 // Default to North
                    }
                }
            }

            // Longitude Input
            Column {
                spacing: 5

                Text {
                    text: "Longitude"
                    font.bold: true
                }

                Row {
                    spacing: 5
                    TextField {
                        id: lonDegreesInput
                        placeholderText: "Degrees (Lon)"
                        width: 50
                        font.pixelSize: 14
                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                    }

                    TextField {
                        id: lonMinutesInput
                        placeholderText: "Minutes (Lon)"
                        width: 50
                        font.pixelSize: 14
                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                    }

                    TextField {
                        id: lonSecondsInput
                        placeholderText: "Seconds (Lon)"
                        width: 50
                        font.pixelSize: 14
                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                    }

                    ComboBox {
                        id: lonDirectionInput
                        width: 40
                        model: ["E", "W"]
                        currentIndex: 0 // Default to East
                    }
                }
            }
        }

        // Plan on Map Button
        Button {
            text: "Plan on Map"
            onClicked: {
                if (pixelInputChoice.checked) {
                    var x = parseFloat(xInput.text)
                    var y = parseFloat(yInput.text)

                    // Validate pixel inputs
                    if (!isNaN(x) && !isNaN(y)) {
                        markOnMapFromCoordinates(x, y, null, null)
                        rolesListModel.append({
                                                  "data": "Pixel - X: " + x + ", Y: " + y
                                              })
                        xInput.text = ""
                        yInput.text = ""
                    } else {
                        console.log("Invalid pixel coordinates")
                    }
                } else {
                    var lonDegrees = parseFloat(lonDegreesInput.text)
                    var lonMinutes = parseFloat(lonMinutesInput.text)
                    var lonSeconds = parseFloat(lonSecondsInput.text)
                    var latDegrees = parseFloat(latDegreesInput.text)
                    var latMinutes = parseFloat(latMinutesInput.text)
                    var latSeconds = parseFloat(latSecondsInput.text)

                    // Validate DMS inputs
                    if (!isNaN(lonDegrees) && !isNaN(lonMinutes) && !isNaN(
                                lonSeconds) && !isNaN(latDegrees) && !isNaN(
                                latMinutes) && !isNaN(latSeconds)) {

                        var longitude = lonDegrees + (lonMinutes / 60) + (lonSeconds / 3600)
                                * (lonDirectionInput.currentText === "W" ? -1 : 1)
                        var latitude = latDegrees + (latMinutes / 60) + (latSeconds / 3600)
                                * (latDirectionInput.currentText === "S" ? -1 : 1)

                        markOnMapFromCoordinates(null, null, latitude,
                                                 longitude) // hantar isyarat coordinate

                        rolesListModel.append({
                                                  "data": "Geo - Lat: " + latDegrees + "° " + latMinutes + "' " + latSeconds + "\" " + latDirectionInput.currentText + ", Lon: " + lonDegrees + "° " + lonMinutes + "' " + lonSeconds + "\" " + lonDirectionInput.currentText
                                              })

                        lonDegreesInput.text = ""
                        lonMinutesInput.text = ""
                        lonSecondsInput.text = ""
                        latDegreesInput.text = ""
                        latMinutesInput.text = ""
                        latSecondsInput.text = ""
                    } else {
                        console.log("Invalid geographic coordinates")
                    }
                }
            }
        }

        // Draw on Map Button
        Button {
            text: "Draw on Map"
            onClicked: {
                rightScreen.startDrawing() // Trigger drawing on the map
                console.log("Drawing mode activated.")
            }
        }

        // Scrollable ListView for tracking coordinates
        Rectangle {
            width: 200
            height: 300
            color: "white"
            border.color: "lightgray"
            border.width: 1

            ListView {
                id: listView
                width: parent.width
                height: parent.height
                model: rolesListModel
                flickableDirection: Flickable.VerticalFlick
                boundsBehavior: Flickable.StopAtBounds
                clip: true

                delegate: listRect

                ScrollBar {
                    id: vbar
                    active: true
                    orientation: Qt.Vertical
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    policy: ScrollBar.AsNeeded
                }

                onCurrentIndexChanged: {
                    selectedItemIndex = currentIndex
                }
            }
        }

        Component {
            id: listRect
            Rectangle {
                id: listElementRect
                height: 30
                width: 150
                color: "white"

                Row {
                    anchors.fill: parent
                    spacing: 5

                    Text {
                        id: elementText
                        width: parent.width
                        height: parent.height
                        text: model.data
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
            }
        }

        // Clear button at the bottom
        Button {
            text: "Clear All"
            width: 150
            onClicked: {
                rolesListModel.clear() // Clear the model
            }
        }

        // Delete button below Clear All button
        Button {
            text: "Delete"
            width: 150
            onClicked: {
                if (selectedItemIndex >= 0) {
                    rolesListModel.remove(selectedItemIndex)
                    selectedItemIndex = -1
                } else {
                    console.log("No item selected for deletion")
                }
            }
        }
    }
}
