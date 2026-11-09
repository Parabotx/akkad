import QtQuick
import Quickshell
import "Palette.js" as Palette

Item {
    id: root
    width: 286
    height: 244
    property var tasks: []

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    property int shownYear: clock.date.getFullYear()
    property int shownMonth: clock.date.getMonth()

    function moveMonth(delta) {
        var next = new Date(root.shownYear, root.shownMonth + delta, 1);
        root.shownYear = next.getFullYear();
        root.shownMonth = next.getMonth();
    }

    function dayCells() {
        var firstDay = new Date(root.shownYear, root.shownMonth, 1).getDay();
        var count = new Date(root.shownYear, root.shownMonth + 1, 0).getDate();
        var cells = [];
        for (var i = 0; i < firstDay; i++) cells.push(0);
        for (var d = 1; d <= count; d++) cells.push(d);
        while (cells.length < 42) cells.push(0);
        return cells;
    }

    function hasTask(day) {
        if (day <= 0) return false;
        var month = String(root.shownMonth + 1).padStart(2, "0");
        var date = String(day).padStart(2, "0");
        var key = root.shownYear + "-" + month + "-" + date;
        return root.tasks.some(function(task) {
            return !task.completed && task.due && task.due.substring(0, 10) === key;
        });
    }

    property var cells: root.dayCells()

    ImperialPanel {
        anchors.fill: parent
        inset: 13

        Column {
            anchors.fill: parent
            spacing: 7

            Row {
                width: parent.width
                height: 24
                Text {
                    text: "CELESTIAL CALENDAR"
                    color: Palette.ivory
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 9
                    font.letterSpacing: 0.9
                    anchors.verticalCenter: parent.verticalCenter
                }
                Item { width: 1; height: 1 }
                Text {
                    text: "‹"
                    color: Palette.gold
                    font.pixelSize: 19
                    width: 18
                    horizontalAlignment: Text.AlignHCenter
                    anchors.verticalCenter: parent.verticalCenter
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.moveMonth(-1)
                    }
                }
                Text {
                    text: "›"
                    color: Palette.gold
                    font.pixelSize: 19
                    width: 18
                    horizontalAlignment: Text.AlignHCenter
                    anchors.verticalCenter: parent.verticalCenter
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.moveMonth(1)
                    }
                }
            }

            Text {
                text: Qt.formatDate(new Date(root.shownYear, root.shownMonth, 1), "MMMM yyyy").toUpperCase()
                color: Palette.amber
                font.family: "Noto Serif"
                font.pixelSize: 15
                font.letterSpacing: 0.6
            }

            Rectangle { width: parent.width; height: 1; color: Palette.line }

            Row {
                width: parent.width
                height: 15
                spacing: 0
                Repeater {
                    model: ["S", "M", "T", "W", "T", "F", "S"]
                    delegate: Text {
                        required property var modelData
                        width: (parent.width) / 7
                        horizontalAlignment: Text.AlignHCenter
                        text: modelData
                        color: Palette.muted
                        font.family: "JetBrainsMono Nerd Font"
                        font.pixelSize: 8
                    }
                }
            }

            Grid {
                id: calendarGrid
                width: parent.width
                height: 132
                columns: 7
                rowSpacing: 2
                columnSpacing: 0

                Repeater {
                    model: root.cells
                    delegate: Item {
                        required property var modelData
                        width: calendarGrid.width / 7
                        height: 20

                        Rectangle {
                            anchors.centerIn: parent
                            width: 19
                            height: 19
                            radius: 9.5
                            color: modelData === clock.date.getDate()
                                   && root.shownMonth === clock.date.getMonth()
                                   && root.shownYear === clock.date.getFullYear()
                                   ? "rgba(201,154,80,0.25)" : "transparent"
                            border.width: modelData === clock.date.getDate()
                                          && root.shownMonth === clock.date.getMonth()
                                          && root.shownYear === clock.date.getFullYear() ? 1 : 0
                            border.color: Palette.gold
                        }

                        Text {
                            anchors.centerIn: parent
                            text: modelData > 0 ? modelData : ""
                            color: modelData === clock.date.getDate()
                                   && root.shownMonth === clock.date.getMonth()
                                   && root.shownYear === clock.date.getFullYear()
                                   ? Palette.ivory : Palette.sandstone
                            font.family: "JetBrainsMono Nerd Font"
                            font.pixelSize: 8
                        }

                        Rectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom
                            width: 3
                            height: 3
                            radius: 1.5
                            color: Palette.amber
                            visible: root.hasTask(modelData)
                        }
                    }
                }
            }

            Text {
                text: "•  MARKED DATES HAVE PENDING TASKS"
                color: Palette.muted
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 7
                font.letterSpacing: 0.3
            }
        }
    }
}
