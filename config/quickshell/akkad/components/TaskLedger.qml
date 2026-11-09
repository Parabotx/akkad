import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import "Palette.js" as Palette

Item {
    id: root
    width: 286
    height: 364

    property var tasks: []
    property bool showCompleted: false
    property var pendingTasks: root.tasks.filter(function(task) { return !task.completed; })
    property var completedTasks: root.tasks.filter(function(task) { return task.completed; })
    property var displayedTasks: root.showCompleted ? root.completedTasks : root.pendingTasks
    property var upcomingTask: {
        var scheduled = root.pendingTasks.filter(function(task) { return task.due && Date.parse(task.due) > root.currentTime; });
        scheduled.sort(function(a, b) { return Date.parse(a.due) - Date.parse(b.due); });
        return scheduled.length ? scheduled[0] : null;
    }
    property var editingTaskId: null

    function loadTasks() {
        try {
            var raw = taskStore.text();
            var parsed = raw && raw.trim().length ? JSON.parse(raw) : [];
            root.tasks = Array.isArray(parsed) ? parsed : [];
        } catch (error) {
            root.tasks = [];
            taskStore.setText("[]");
        }
    }

    function saveTasks() {
        taskStore.setText(JSON.stringify(root.tasks, null, 2));
    }

    function addTask() {
        var title = titleField.text.trim();
        if (!title.length) return;
        var due = dueField.text.trim();
        if (due.length && !/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}$/.test(due)) {
            dueField.placeholderText = "Use YYYY-MM-DDTHH:mm";
            return;
        }

        if (root.editingTaskId !== null) {
            root.tasks = root.tasks.map(function(task) {
                var copy = Object.assign({}, task);
                if (copy.id === root.editingTaskId) {
                    copy.title = title;
                    copy.due = due;
                }
                return copy;
            });
            root.editingTaskId = null;
        } else {
            var next = root.tasks.slice();
            next.push({
                id: Date.now(),
                title: title,
                due: due,
                completed: false,
                created: new Date().toISOString()
            });
            root.tasks = next;
        }

        root.saveTasks();
        titleField.text = "";
        dueField.text = "";
        titleField.placeholderText = "Add an imperial duty…";
        dueField.placeholderText = "Due · YYYY-MM-DDTHH:mm";
    }

    function beginEdit(task) {
        root.editingTaskId = task.id;
        titleField.text = task.title;
        dueField.text = task.due || "";
        titleField.forceActiveFocus();
    }

    function cancelEdit() {
        root.editingTaskId = null;
        titleField.text = "";
        dueField.text = "";
        titleField.placeholderText = "Add an imperial duty…";
        dueField.placeholderText = "Due · YYYY-MM-DDTHH:mm";
    }

    function setCompleted(taskId, value) {
        var next = root.tasks.map(function(task) {
            var copy = Object.assign({}, task);
            if (copy.id === taskId) copy.completed = value;
            return copy;
        });
        root.tasks = next;
        root.saveTasks();
    }

    function deleteTask(taskId) {
        root.tasks = root.tasks.filter(function(task) { return task.id !== taskId; });
        root.saveTasks();
    }

    FileView {
        id: taskStore
        path: Quickshell.dataPath("tasks.json")
        blockLoading: true
        atomicWrites: true
        watchChanges: true
        onFileChanged: root.loadTasks()
    }

    Timer {
        interval: 60000
        repeat: true
        running: true
        onTriggered: root.currentTime = Date.now()
    }

    Component.onCompleted: root.loadTasks()

    ImperialPanel {
        anchors.fill: parent
        inset: 14

        Column {
            anchors.fill: parent
            spacing: 9

            Row {
                width: parent.width
                height: 24
                spacing: 8

                Text {
                    text: "TASK LEDGER"
                    color: Palette.ivory
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 11
                    font.letterSpacing: 1.4
                    anchors.verticalCenter: parent.verticalCenter
                }

                Item { width: 1; height: 1 }

                Text {
                    text: root.pendingTasks.length + " PENDING"
                    color: Palette.amber
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 9
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Rectangle {
                width: parent.width
                height: 1
                color: Palette.line
            }

            TextField {
                id: titleField
                width: parent.width
                height: 31
                placeholderText: root.editingTaskId !== null ? "Edit the selected duty…" : "Add an imperial duty…"
                font.family: "Noto Sans"
                font.pixelSize: 11
                color: Palette.ivory
                leftPadding: 10
                rightPadding: 10
                selectByMouse: true
                onAccepted: root.addTask()
                background: Rectangle {
                    color: "rgba(9, 9, 9, 0.62)"
                    border.width: 1
                    border.color: titleField.activeFocus ? Palette.gold : Palette.faint
                    radius: 5
                }
            }

            Row {
                width: parent.width
                height: 28
                spacing: 6

                TextField {
                    id: dueField
                    width: parent.width - (root.editingTaskId !== null ? 108 : 80)
                    height: 28
                    placeholderText: "Due · YYYY-MM-DDTHH:mm"
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 8
                    color: Palette.sandstone
                    leftPadding: 8
                    rightPadding: 8
                    selectByMouse: true
                    background: Rectangle {
                        color: "rgba(9, 9, 9, 0.48)"
                        border.width: 1
                        border.color: dueField.activeFocus ? Palette.gold : Palette.faint
                        radius: 5
                    }
                }

                Rectangle {
                    width: 68
                    height: 28
                    radius: 5
                    color: addMouse.containsMouse ? "rgba(229,163,79,0.24)" : "rgba(201,154,80,0.12)"
                    border.width: 1
                    border.color: Palette.line

                    Text {
                        anchors.centerIn: parent
                        text: root.editingTaskId !== null ? "✓  SAVE" : "＋  ADD"
                        color: Palette.amber
                        font.family: "JetBrainsMono Nerd Font"
                        font.pixelSize: 9
                    }

                    MouseArea {
                        id: addMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.addTask()
                    }
                }

                Rectangle {
                    width: root.editingTaskId !== null ? 28 : 0
                    height: 28
                    radius: 5
                    visible: root.editingTaskId !== null
                    color: cancelMouse.containsMouse ? "rgba(201,154,80,0.16)" : "transparent"
                    border.width: visible ? 1 : 0
                    border.color: Palette.faint
                    Text {
                        anchors.centerIn: parent
                        text: "×"
                        color: Palette.sandstone
                        font.pixelSize: 15
                    }
                    MouseArea {
                        id: cancelMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.cancelEdit()
                    }
                }
            }

            Row {
                width: parent.width
                height: 19
                spacing: 7

                Text {
                    text: root.showCompleted ? "COMPLETED" : "CURRENT DUTIES"
                    color: Palette.gold
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 8
                    font.letterSpacing: 1.1
                    anchors.verticalCenter: parent.verticalCenter
                }

                Item { width: 1; height: 1 }

                Text {
                    text: root.showCompleted ? "SHOW PENDING" : ("DONE " + root.completedTasks.length)
                    color: Palette.muted
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 8
                    anchors.verticalCenter: parent.verticalCenter
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.showCompleted = !root.showCompleted
                }
            }

            Flickable {
                id: taskScroll
                width: parent.width
                height: 126
                clip: true
                contentHeight: taskRows.implicitHeight
                boundsBehavior: Flickable.StopAtBounds

                Column {
                    id: taskRows
                    width: taskScroll.width
                    spacing: 5

                    Repeater {
                        model: root.displayedTasks
                        delegate: Item {
                            required property var modelData
                            width: taskRows.width
                            height: 26

                            Rectangle {
                                x: 0
                                y: 7
                                width: 11
                                height: 11
                                radius: 5.5
                                color: modelData.completed ? Palette.gold : "transparent"
                                border.width: 1
                                border.color: modelData.completed ? Palette.gold : Palette.sandstone

                                Text {
                                    anchors.centerIn: parent
                                    text: "✓"
                                    color: Palette.obsidian
                                    font.pixelSize: 8
                                    visible: modelData.completed
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: root.setCompleted(modelData.id, !modelData.completed)
                                }
                            }

                            Text {
                                x: 18
                                y: 2
                                width: parent.width - 72
                                text: modelData.title
                                color: modelData.completed ? Palette.muted : Palette.ivory
                                font.family: "Noto Sans"
                                font.pixelSize: 10
                                elide: Text.ElideRight
                                font.strikeout: modelData.completed
                            }

                            Text {
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                text: "✎"
                                color: Palette.gold
                                font.pixelSize: 13
                                width: 17
                                horizontalAlignment: Text.AlignHCenter

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: root.beginEdit(modelData)
                                }
                            }

                            Text {
                                anchors.right: parent.right
                                anchors.rightMargin: 22
                                anchors.verticalCenter: parent.verticalCenter
                                text: "×"
                                color: Palette.muted
                                font.pixelSize: 15
                                width: 15
                                horizontalAlignment: Text.AlignHCenter

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: root.deleteTask(modelData.id)
                                }
                            }
                        }
                    }
                }

                Text {
                    anchors.centerIn: parent
                    visible: root.displayedTasks.length === 0
                    text: root.showCompleted ? "No completed tasks" : "No duties recorded"
                    color: Palette.muted
                    font.family: "Noto Serif"
                    font.italic: true
                    font.pixelSize: 10
                }
            }

            Rectangle {
                width: parent.width
                height: 1
                color: Palette.faint
            }

            Column {
                width: parent.width
                spacing: 4

                Text {
                    text: "UPCOMING"
                    color: Palette.gold
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 8
                    font.letterSpacing: 1.1
                }

                Text {
                    width: parent.width
                    text: root.upcomingTask
                          ? root.upcomingTask.title + " · " + root.upcomingTask.due.replace("T", " ")
                          : "No scheduled duties"
                    color: root.upcomingTask ? Palette.sandstone : Palette.muted
                    font.family: "Noto Sans"
                    font.pixelSize: 9
                    elide: Text.ElideRight
                }
            }
        }
    }
}
