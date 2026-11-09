import QtQuick
import Quickshell
import "Palette.js" as Palette

Item {
    id: root
    property string appName: ""
    property string iconName: "application-x-executable"
    property var command: []
    property bool optional: false
    property int iconSize: 19
    property int buttonSize: 34
    property string tooltip: appName
    readonly property var entry: appName.length > 0 ? DesktopEntries.heuristicLookup(appName) : null

    width: buttonSize
    height: buttonSize
    visible: !optional || entry !== null

    Rectangle {
        anchors.fill: parent
        radius: 8
        color: mouse.containsMouse ? "rgba(201, 154, 80, 0.17)" : "transparent"
        border.width: mouse.containsMouse ? 1 : 0
        border.color: Palette.line

        Behavior on color { ColorAnimation { duration: 120 } }
    }

    Image {
        anchors.centerIn: parent
        width: root.iconSize
        height: root.iconSize
        source: Quickshell.iconPath(
            root.entry && root.entry.icon ? root.entry.icon : root.iconName,
            "application-x-executable"
        )
        sourceSize.width: root.iconSize * 2
        sourceSize.height: root.iconSize * 2
        fillMode: Image.PreserveAspectFit
        smooth: true
        opacity: mouse.containsMouse ? 1.0 : 0.88
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            if (root.entry) {
                root.entry.execute();
            } else if (root.command && root.command.length > 0) {
                Quickshell.execDetached({ command: root.command });
            }
        }
    }

    Rectangle {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: mouse.containsMouse ? 12 : 4
        height: 2
        radius: 1
        color: Palette.amber
        opacity: mouse.containsMouse ? 0.95 : 0.48
        Behavior on width { NumberAnimation { duration: 120 } }
    }
}
