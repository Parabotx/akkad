import QtQuick
import "Palette.js" as Palette

Item {
    id: root
    width: 474
    height: 68

    ImperialPanel {
        anchors.fill: parent
        inset: 7

        Row {
            anchors.centerIn: parent
            spacing: 7

            AppIconButton {
                appName: "Fuzzel"
                iconName: "view-app-grid"
                command: ["fuzzel"]
                buttonSize: 40
                iconSize: 21
                tooltip: "Application launcher"
            }
            AppIconButton {
                appName: "Firefox"
                iconName: "firefox"
                command: ["firefox"]
                buttonSize: 40
                iconSize: 21
            }
            AppIconButton {
                appName: "Thunar"
                iconName: "system-file-manager"
                command: ["thunar"]
                buttonSize: 40
                iconSize: 21
            }
            AppIconButton {
                appName: "foot"
                iconName: "utilities-terminal"
                command: ["foot"]
                buttonSize: 40
                iconSize: 21
            }

            Rectangle {
                width: 1
                height: 29
                color: Palette.line
                anchors.verticalCenter: parent.verticalCenter
            }

            AppIconButton {
                appName: "Visual Studio Code"
                iconName: "visual-studio-code"
                optional: true
                buttonSize: 40
                iconSize: 21
            }
            AppIconButton {
                appName: "Discord"
                iconName: "discord"
                optional: true
                buttonSize: 40
                iconSize: 21
            }
            AppIconButton {
                appName: "pavucontrol"
                iconName: "audio-volume-high"
                command: ["pavucontrol"]
                buttonSize: 40
                iconSize: 21
            }
            AppIconButton {
                appName: ""
                iconName: "user-trash"
                command: ["thunar", "trash:///"]
                buttonSize: 40
                iconSize: 21
                tooltip: "Trash"
            }
        }
    }
}
