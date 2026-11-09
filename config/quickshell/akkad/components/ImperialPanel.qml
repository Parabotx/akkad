import QtQuick
import "Palette.js" as Palette

Rectangle {
    id: root
    property int inset: 14
    default property alias contentData: content.data

    color: Palette.panel
    radius: 10
    border.width: 1
    border.color: Palette.line
    clip: true

    Rectangle {
        anchors.fill: parent
        anchors.margins: 3
        color: "transparent"
        radius: 8
        border.width: 1
        border.color: Palette.faint
    }

    Rectangle {
        x: 0
        y: 14
        width: 13
        height: 1
        color: Palette.gold
        opacity: 0.72
    }

    Rectangle {
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 14
        width: 13
        height: 1
        color: Palette.gold
        opacity: 0.72
    }

    Item {
        id: content
        anchors.fill: parent
        anchors.margins: root.inset
    }
}
