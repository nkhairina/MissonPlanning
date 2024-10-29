import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: rightScreen
    anchors {
        top: parent.top
        bottom: parent.bottom
        right: parent.right
    }
    width: parent.width * 0.85
    height: parent.height // Make it responsive

    property real zoomFactor: 1.0
    property var lastDotMarker: null
    property var lastCoordinateLabel: null

    property real latTopLeft: 32.8713
    property real lonTopLeft: 100.4694
    property real latBottomLeft: 35.0677
    property real lonBottomLeft: 100.8735
    property real latTopRight: 32.8713
    property real lonTopRight: 102.0034
    property real latBottomRight: 35.0677
    property real lonBottomRight: 102.4075

    // 4 titik referennce real coordinate
    property var referencePoints: [{
            "imageX": 148,
            "imageY": 19,
            "skyLat": 3.5000,
            "skyLon": 100.9997
        }, {
            "imageX": 148,
            "imageY": 1478,
            "skyLat": 2.5003,
            "skyLon": 101.0000
        }, {
            "imageX": 1604,
            "imageY": 19,
            "skyLat": 3.5000,
            "skyLon": 102.0006
        }, {
            "imageX": 1604,
            "imageY": 1478,
            "skyLat": 2.5003,
            "skyLon": 102.0000
        }]

    // isyarat menandakan peta untuk coordinate
    signal markOnMapFromCoordinates(real x, real y, real latitude, real longitude)

    // Ensure leftScreen is accessible and defined
    Connections {
        target: leftScreen // Ensure leftScreen is defined and accessible
        function onMarkOnMapFromCoordinates(x, y, latitude, longitude) {
            markOnMap(x, y, latitude, longitude)
        }
    }

    function pixelToCoordinate(x, y) {
        var latScale = (referencePoints[1].skyLat - referencePoints[0].skyLat)
                / (referencePoints[1].imageY - referencePoints[0].imageY)
        var lonScale = (referencePoints[2].skyLon - referencePoints[0].skyLon)
                / (referencePoints[2].imageX - referencePoints[0].imageX)

        return {
            "latitude": referencePoints[0].skyLat + latScale * (y - referencePoints[0].imageY),
            "longitude": referencePoints[0].skyLon + lonScale * (x - referencePoints[0].imageX)
        }
    }

    function decimalToDMS(decimal, isLatitude) {
        var degrees = Math.floor(Math.abs(decimal))
        var minutes = Math.floor((Math.abs(decimal) - degrees) * 60)
        var seconds = Math.round(((Math.abs(
                                       decimal) - degrees) * 60 - minutes) * 60)

        // Format degrees, minutes, and seconds with leading zeros if necessary
        var degreesStr = degrees.toString().padStart(
                    2, '0') // Ensures 2 digits for degrees
        var minutesStr = minutes.toString().padStart(
                    2, '0') // Ensures 2 digits for minutes
        var secondsStr = seconds.toString().padStart(
                    2, '0') // Ensures 2 digits for seconds

        // Determine the direction (N/S for latitude, E/W for longitude)
        var direction = isLatitude ? (decimal >= 0 ? "N" : "S") : (decimal >= 0 ? "E" : "W")

        // Return the formatted DMS string
        return degreesStr + minutesStr + secondsStr + direction
    }

    Flickable {
        id: flickable
        anchors.fill: parent
        contentWidth: mapContainer.width * zoomFactor
        contentHeight: mapContainer.height * zoomFactor
        flickableDirection: Flickable.HorizontalFlick | Flickable.VerticalFlick
        clip: true

        onContentWidthChanged: {
            contentX = Math.max(0, Math.min(contentX, contentWidth - width))
        }

        onContentHeightChanged: {
            contentY = Math.max(0, Math.min(contentY, contentHeight - height))
        }

        //masukkan gambar peta
        Item {
            id: mapContainer
            width: 256 * 9 // 9 columns
            height: 256 * 7 // 7 rows
            scale: zoomFactor

            ListModel {
                id: imageModel
                Component.onCompleted: {
                    for (var i = 1; i <= 63; i++) {
                        imageModel.append({
                                              "source": "qrc:/ui/assests/Map/" + i + ".jpg"
                                          })
                    }
                }
            }

            Repeater {
                model: imageModel
                Image {
                    source: model.source
                    width: 256
                    height: 256
                    fillMode: Image.Stretch
                    x: (index % 9) * 256
                    y: Math.floor(index / 9) * 256
                }
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                onPositionChanged: event => {
                                       var point = mapToItem(mapContainer,
                                                             event.x, event.y)
                                       xMarker.x = point.x - xMarker.width / 2
                                       xMarker.y = point.y - xMarker.height / 2
                                       xMarker.visible = true
                                   }

                onClicked: event => {
                               var point = mapToItem(mapContainer,
                                                     event.x, event.y)
                               var coords = rightScreen.pixelToCoordinate(
                                   point.x, point.y)
                               markOnMap(point.x, point.y, coords.latitude,
                                         coords.longitude)
                           }
            }
        }
    }
    // tanda "X"  dalam peta
    Rectangle {
        id: xMarker
        width: 15
        height: 15
        color: "transparent"

        Canvas {
            anchors.fill: parent
            onPaint: {
                var ctx = getContext("2d")
                ctx.strokeStyle = "black"
                ctx.lineWidth = 1
                ctx.beginPath()
                ctx.moveTo(width / 2, 0)
                ctx.lineTo(width / 2, height)
                ctx.moveTo(0, height / 2)
                ctx.lineTo(width, height / 2)
                ctx.stroke()
            }
        }
    }
    // function tanda lokasi coodinate
    function markOnMap(x, y, latitude, longitude) {
        if (lastDotMarker) {
            lastDotMarker.destroy()
        }
        if (lastCoordinateLabel) {
            lastCoordinateLabel.destroy()
        }

        lastDotMarker = Qt.createQmlObject(
                    'import QtQuick 2.15; Rectangle { width: 5; height: 5; color: "red"; radius: 2.5; }',
                    mapContainer)
        lastDotMarker.x = x - lastDotMarker.width / 2
        lastDotMarker.y = y - lastDotMarker.height / 2

        lastCoordinateLabel
                = Qt.createQmlObject('import QtQuick 2.15; Text { text: "Pixel: ('
                                     + Math.round(x) + ', ' + Math.round(
                                         y) + ')" + "\\nLat: ' + decimalToDMS(latitude,
                                                                              true) + '\\nLon: '
                                     + decimalToDMS(longitude,
                                                    false) + '"; font.pixelSize: 12; color: "red"; }',
                                     mapContainer)
        lastCoordinateLabel.x = x - lastCoordinateLabel.width / 2
        lastCoordinateLabel.y = lastDotMarker.y + lastDotMarker.height + 10
    }

    Button {
        id: zoomInButton
        text: "+"
        width: 40
        height: 40
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 60
        onClicked: {
            zoomFactor = Math.min(zoomFactor * 1.1, 4.0)
            flickable.contentWidth = mapContainer.width * zoomFactor
            flickable.contentHeight = mapContainer.height * zoomFactor
            mapContainer.scale = zoomFactor // Add this line
        }
    }

    Button {
        id: zoomOutButton
        text: "-"
        width: 40
        height: 40
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        onClicked: {
            zoomFactor = Math.max(zoomFactor / 1.1, 0.5) // Allows more zoom-out
            flickable.contentWidth = mapContainer.width * zoomFactor
            flickable.contentHeight = mapContainer.height * zoomFactor
            mapContainer.scale = zoomFactor // Add this line
        }
    }
}
