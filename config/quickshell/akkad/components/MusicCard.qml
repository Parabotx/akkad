import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import "Palette.js" as Palette

Item {
    id: root
    width: 438
    height: 132

    property var player: {
        var players = Mpris.players.values;
        for (var i = 0; i < players.length; i++) {
            if (players[i].isPlaying) return players[i];
        }
        return players.length ? players[0] : null;
    }

    function formatTime(seconds) {
        var value = Math.max(0, Math.floor(Number(seconds || 0)));
        var minutes = Math.floor(value / 60);
        var remainder = value % 60;
        return minutes + ":" + (remainder < 10 ? "0" : "") + remainder;
    }

    Timer {
        interval: 1000
        repeat: true
        running: root.player !== null && root.player.isPlaying
        onTriggered: {
            if (root.player) root.player.positionChanged();
        }
    }

    ImperialPanel {
        anchors.fill: parent
        inset: 12

        Row {
            anchors.fill: parent
            spacing: 12

            Rectangle {
                width: 84
                height: 84
                radius: 6
                color: Palette.bronze
                border.width: 1
                border.color: Palette.line
                anchors.verticalCenter: parent.verticalCenter
                clip: true

                Image {
                    anchors.fill: parent
                    source: root.player ? root.player.trackArtUrl : ""
                    fillMode: Image.PreserveAspectCrop
                    asynchronous: true
                    visible: root.player !== null && root.player.trackArtUrl.length > 0
                }

                Text {
                    anchors.centerIn: parent
                    text: "✦"
                    color: Palette.amber
                    font.pixelSize: 30
                    visible: !root.player || !root.player.trackArtUrl.length
                }
            }

            Column {
                width: parent.width - 96
                anchors.verticalCenter: parent.verticalCenter
                spacing: 7

                Row {
                    width: parent.width
                    Text {
                        text: "IMPERIAL TRANSMISSION"
                        color: Palette.gold
                        font.family: "JetBrainsMono Nerd Font"
                        font.pixelSize: 7
                        font.letterSpacing: 1.1
                    }
                    Item { width: 1; height: 1 }
                    Text {
                        text: root.player ? (root.player.isPlaying ? "LIVE" : "PAUSED") : "IDLE"
                        color: root.player && root.player.isPlaying ? Palette.amber : Palette.muted
                        font.family: "JetBrainsMono Nerd Font"
                        font.pixelSize: 7
                    }
                }

                Text {
                    width: parent.width
                    text: root.player && root.player.trackTitle.length ? root.player.trackTitle : "No active media session"
                    color: Palette.ivory
                    font.family: "Noto Serif"
                    font.pixelSize: 14
                    elide: Text.ElideRight
                }

                Text {
                    width: parent.width
                    text: root.player ? (root.player.trackArtist || root.player.identity || "Unknown artist") : "Start a media player with MPRIS support"
                    color: Palette.sandstone
                    font.family: "Noto Sans"
                    font.pixelSize: 9
                    elide: Text.ElideRight
                }

                Rectangle {
                    width: parent.width
                    height: 3
                    radius: 1.5
                    color: Palette.bronze

                    Rectangle {
                        width: parent.width * (root.player && root.player.length > 0
                                               ? Math.max(0, Math.min(1, root.player.position / root.player.length))
                                               : 0)
                        height: parent.height
                        radius: 1.5
                        color: Palette.amber
                    }
                }

                Row {
                    width: parent.width
                    height: 18
                    spacing: 10

                    Text {
                        text: root.player ? root.formatTime(root.player.position) + " / " + root.formatTime(root.player.length) : "—:— / —:—"
                        color: Palette.muted
                        font.family: "JetBrainsMono Nerd Font"
                        font.pixelSize: 7
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Item { width: 1; height: 1 }

                    Text {
                        text: "⏮"
                        color: root.player && root.player.canGoPrevious ? Palette.ivory : Palette.muted
                        font.pixelSize: 13
                        anchors.verticalCenter: parent.verticalCenter
                        MouseArea {
                            anchors.fill: parent
                            enabled: root.player !== null && root.player.canGoPrevious
                            cursorShape: Qt.PointingHandCursor
                            onClicked: root.player.previous()
                        }
                    }

                    Text {
                        text: root.player && root.player.isPlaying ? "Ⅱ" : "▶"
                        color: root.player && root.player.canTogglePlaying ? Palette.amber : Palette.muted
                        font.pixelSize: 13
                        anchors.verticalCenter: parent.verticalCenter
                        MouseArea {
                            anchors.fill: parent
                            enabled: root.player !== null && root.player.canTogglePlaying
                            cursorShape: Qt.PointingHandCursor
                            onClicked: root.player.togglePlaying()
                        }
                    }

                    Text {
                        text: "⏭"
                        color: root.player && root.player.canGoNext ? Palette.ivory : Palette.muted
                        font.pixelSize: 13
                        anchors.verticalCenter: parent.verticalCenter
                        MouseArea {
                            anchors.fill: parent
                            enabled: root.player !== null && root.player.canGoNext
                            cursorShape: Qt.PointingHandCursor
                            onClicked: root.player.next()
                        }
                    }

                    Text {
                        text: root.player && root.player.shuffle ? "⤨" : "⇄"
                        color: root.player && root.player.shuffleSupported ? Palette.gold : Palette.muted
                        font.pixelSize: 12
                        anchors.verticalCenter: parent.verticalCenter
                        MouseArea {
                            anchors.fill: parent
                            enabled: root.player !== null && root.player.canControl && root.player.shuffleSupported
                            cursorShape: Qt.PointingHandCursor
                            onClicked: root.player.shuffle = !root.player.shuffle
                        }
                    }

                    Text {
                        text: root.player && root.player.loopState !== MprisLoopState.None ? "⟳" : "↻"
                        color: root.player && root.player.loopSupported ? Palette.gold : Palette.muted
                        font.pixelSize: 12
                        anchors.verticalCenter: parent.verticalCenter
                        MouseArea {
                            anchors.fill: parent
                            enabled: root.player !== null && root.player.canControl && root.player.loopSupported
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                if (root.player.loopState === MprisLoopState.None)
                                    root.player.loopState = MprisLoopState.Playlist;
                                else if (root.player.loopState === MprisLoopState.Playlist)
                                    root.player.loopState = MprisLoopState.Track;
                                else
                                    root.player.loopState = MprisLoopState.None;
                            }
                        }
                    }
                }
            }
        }
    }
}
