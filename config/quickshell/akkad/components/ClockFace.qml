import QtQuick
import Quickshell
import "Palette.js" as Palette

Item {
    id: root
    implicitWidth: 470
    implicitHeight: 218

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    Rectangle {
        id: outerOrbit
        width: 178
        height: 178
        radius: 89
        anchors.horizontalCenter: parent.horizontalCenter
        y: 0
        color: "transparent"
        border.width: 1
        border.color: Palette.line

        Rectangle {
            anchors.fill: parent
            anchors.margins: 10
            radius: 79
            color: "transparent"
            border.width: 1
            border.color: Palette.faint
        }

        Rectangle {
            anchors.fill: parent
            anchors.margins: 25
            radius: 64
            color: "transparent"
            border.width: 1
            border.color: "rgba(229, 163, 79, 0.25)"
        }

        Rectangle {
            width: 5
            height: 5
            radius: 2.5
            color: Palette.amber
            anchors.horizontalCenter: parent.horizontalCenter
            y: 5
        }

        Rectangle {
            width: 4
            height: 4
            radius: 2
            color: Palette.gold
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
        }

        Rectangle {
            width: 4
            height: 4
            radius: 2
            color: Palette.gold
            anchors.verticalCenter: parent.verticalCenter
            x: 5
        }

        Rectangle {
            width: 4
            height: 4
            radius: 2
            color: Palette.gold
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 5
        }

        Rectangle {
            id: orbitMarker
            width: 1
            height: 178
            color: "transparent"
            anchors.centerIn: parent
            Rectangle {
                width: 3
                height: 3
                radius: 1.5
                color: Palette.amber
                anchors.horizontalCenter: parent.horizontalCenter
                y: 20
            }
            RotationAnimation on rotation {
                from: 0
                to: 360
                duration: 110000
                loops: Animation.Infinite
            }
        }

        Text {
            anchors.centerIn: parent
            text: Qt.formatDateTime(clock.date, "HH:mm")
            color: Palette.ivory
            font.family: "Noto Serif"
            font.pixelSize: 43
            font.letterSpacing: 2
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 37
            text: Qt.formatDateTime(clock.date, "ss")
            color: Palette.amber
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 9
            opacity: 0.82
        }
    }

    Text {
        anchors.top: outerOrbit.bottom
        anchors.topMargin: 7
        anchors.horizontalCenter: parent.horizontalCenter
        text: Qt.formatDateTime(clock.date, "dddd, MMMM dd").toUpperCase()
        color: Palette.gold
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 10
        font.letterSpacing: 1.2
    }

    Rectangle {
        anchors.top: parent.top
        anchors.topMargin: 77
        anchors.left: parent.left
        anchors.leftMargin: 18
        width: 74
        height: 1
        color: Palette.line
    }

    Rectangle {
        anchors.top: parent.top
        anchors.topMargin: 77
        anchors.right: parent.right
        anchors.rightMargin: 18
        width: 74
        height: 1
        color: Palette.line
    }

    Text {
        anchors.top: parent.top
        anchors.topMargin: 194
        anchors.horizontalCenter: parent.horizontalCenter
        text: "A civilization endures through what it records."
        color: Palette.sandstone
        font.family: "Noto Serif"
        font.italic: true
        font.pixelSize: 10
        opacity: 0.9
    }

    Text {
        anchors.top: parent.top
        anchors.topMargin: 207
        anchors.horizontalCenter: parent.horizontalCenter
        text: "AN AKKAD MAXIM · ORIGINAL"
        color: Palette.muted
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 7
        font.letterSpacing: 1.1
    }
}
