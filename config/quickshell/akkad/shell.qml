//@ pragma ShellId akkad
//@ pragma DataDir $BASE/akkad-shell
//@ pragma IconTheme Papirus

import Quickshell
import Quickshell.Hyprland
import QtQuick
import "components"
import "components/Palette.js" as Palette

ShellRoot {
    id: root
    readonly property var primaryScreen: Quickshell.screens.length > 0 ? Quickshell.screens[0] : null

    PanelWindow {
        id: navigation
        screen: root.primaryScreen
        anchors { top: true; left: true }
        margins {
            top: 10
            left: root.primaryScreen ? Math.max(8, (root.primaryScreen.width - implicitWidth) / 2) : 8
        }
        implicitWidth: 620
        implicitHeight: 48
        color: "transparent"

        Rectangle {
            anchors.fill: parent
            radius: 10
            color: Palette.panel
            border.width: 1
            border.color: Palette.line

            Rectangle {
                anchors.fill: parent
                anchors.margins: 3
                radius: 7
                color: "transparent"
                border.width: 1
                border.color: Palette.faint
            }

            Row {
                anchors.centerIn: parent
                spacing: 7

                Row {
                    height: 30
                    spacing: 5
                    anchors.verticalCenter: parent.verticalCenter

                    Repeater {
                        model: Hyprland.workspaces.values
                        delegate: Item {
                            required property var modelData
                            width: 10
                            height: 28

                            Rectangle {
                                width: modelData.focused ? 7 : 5
                                height: modelData.focused ? 7 : 5
                                radius: 4
                                anchors.centerIn: parent
                                color: modelData.focused ? Palette.amber : Palette.bronze
                                opacity: modelData.focused ? 1.0 : 0.78
                                border.width: modelData.focused ? 1 : 0
                                border.color: Palette.ivory
                            }

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: modelData.activate()
                            }
                        }
                    }
                }

                Rectangle {
                    width: 1
                    height: 19
                    color: Palette.line
                    anchors.verticalCenter: parent.verticalCenter
                }

                AppIconButton {
                    appName: "foot"
                    iconName: "utilities-terminal"
                    command: ["foot"]
                    buttonSize: 30
                    iconSize: 17
                }
                AppIconButton {
                    appName: "Thunar"
                    iconName: "system-file-manager"
                    command: ["thunar"]
                    buttonSize: 30
                    iconSize: 17
                }
                AppIconButton {
                    appName: "Firefox"
                    iconName: "firefox"
                    command: ["firefox"]
                    buttonSize: 30
                    iconSize: 17
                }
                AppIconButton {
                    appName: "playerctl"
                    iconName: "audio-x-generic"
                    command: ["playerctl", "play-pause"]
                    buttonSize: 30
                    iconSize: 17
                }

                Rectangle {
                    width: 1
                    height: 24
                    color: Palette.line
                    anchors.verticalCenter: parent.verticalCenter
                }

                Item {
                    width: 31
                    height: 31

                    Rectangle {
                        anchors.centerIn: parent
                        width: 25
                        height: 25
                        radius: 12.5
                        color: "rgba(201,154,80,0.08)"
                        border.width: 1
                        border.color: Palette.gold
                    }
                    Rectangle {
                        anchors.centerIn: parent
                        width: 17
                        height: 17
                        rotation: 45
                        color: "transparent"
                        border.width: 1
                        border.color: Palette.amber
                    }
                    Rectangle {
                        anchors.centerIn: parent
                        width: 5
                        height: 5
                        rotation: 45
                        color: Palette.amber
                    }
                    Rectangle {
                        width: 12
                        height: 1
                        color: Palette.gold
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                    }
                    Rectangle {
                        width: 12
                        height: 1
                        color: Palette.gold
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                    }
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: Quickshell.execDetached({ command: ["fuzzel"] })
                    }
                }

                Rectangle {
                    width: 1
                    height: 24
                    color: Palette.line
                    anchors.verticalCenter: parent.verticalCenter
                }

                AppIconButton {
                    appName: "Visual Studio Code"
                    iconName: "visual-studio-code"
                    optional: true
                    buttonSize: 30
                    iconSize: 17
                }
                AppIconButton {
                    appName: "Discord"
                    iconName: "discord"
                    optional: true
                    buttonSize: 30
                    iconSize: 17
                }
                AppIconButton {
                    appName: "pavucontrol"
                    iconName: "preferences-system"
                    command: ["pavucontrol"]
                    buttonSize: 30
                    iconSize: 17
                }
            }
        }
    }

    PanelWindow {
        id: clockPanel
        screen: root.primaryScreen
        anchors { top: true; left: true }
        margins {
            top: 75
            left: root.primaryScreen ? Math.max(8, (root.primaryScreen.width - implicitWidth) / 2) : 8
        }
        implicitWidth: 490
        implicitHeight: 226
        color: "transparent"

        ClockFace { anchors.centerIn: parent }
    }

    PanelWindow {
        id: systemPanel
        screen: root.primaryScreen
        anchors { top: true; left: true }
        margins { top: 225; left: 18 }
        implicitWidth: 260
        implicitHeight: 354
        color: "transparent"

        SystemMonitor { anchors.centerIn: parent }
    }

    PanelWindow {
        id: musicPanel
        screen: root.primaryScreen
        anchors { top: true; left: true }
        margins {
            top: 314
            left: root.primaryScreen ? Math.max(8, (root.primaryScreen.width - implicitWidth) / 2) : 8
        }
        implicitWidth: 452
        implicitHeight: 146
        color: "transparent"

        MusicCard { anchors.centerIn: parent }
    }

    PanelWindow {
        id: ledgerPanel
        screen: root.primaryScreen
        anchors { top: true; right: true }
        margins { top: 177; right: 18 }
        implicitWidth: 300
        implicitHeight: 624
        color: "transparent"

        Column {
            anchors.centerIn: parent
            spacing: 12

            TaskLedger {
                id: taskLedger
            }
            CalendarCard {
                tasks: taskLedger.tasks
            }
        }
    }

    PanelWindow {
        id: dockPanel
        screen: root.primaryScreen
        anchors { bottom: true; left: true }
        margins {
            bottom: 14
            left: root.primaryScreen ? Math.max(8, (root.primaryScreen.width - implicitWidth) / 2) : 8
        }
        implicitWidth: 486
        implicitHeight: 76
        color: "transparent"

        DockBar { anchors.centerIn: parent }
    }
}
