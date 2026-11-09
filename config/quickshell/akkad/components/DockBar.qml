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
                buttonSize: 36
                iconSize: 19
                tooltip: "Application launcher"
            }
            AppIconButton {
                appName: "Firefox"
                iconName: "firefox"
                command: ["firefox"]
                buttonSize: 36
                iconSize: 19
            }
            AppIconButton {
                appName: "Thunar"
                iconName: "system-file-manager"
                command: ["thunar"]
                buttonSize: 36
                iconSize: 19
            }
            AppIconButton {
                appName: "foot"
                iconName: "utilities-terminal"
                command: ["foot"]
                buttonSize: 36
                iconSize: 19
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
                buttonSize: 36
                iconSize: 19
            }
            AppIconButton {
                appName: "Discord"
                iconName: "discord"
                optional: true
                buttonSize: 36
                iconSize: 19
            }
            AppIconButton {
                appName: "Spotify"
                iconName: "spotify"
                optional: true
                buttonSize: 36
                iconSize: 19
            }
            AppIconButton {
                appName: "VLC"
                iconName: "vlc"
                optional: true
                buttonSize: 36
                iconSize: 19
            }
            AppIconButton {
                appName: "pavucontrol"
                iconName: "audio-volume-high"
                command: ["pavucontrol"]
                buttonSize: 36
                iconSize: 19
            }
            AppIconButton {
                appName: ""
                iconName: "user-trash"
                command: ["thunar", "trash:///"]
                buttonSize: 36
                iconSize: 19
                tooltip: "Trash"
            }
        }
    }
}
