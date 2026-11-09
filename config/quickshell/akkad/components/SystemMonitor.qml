import QtQuick
import Quickshell
import Quickshell.Io
import "Palette.js" as Palette

Item {
    id: root
    width: 248
    height: 342

    property var metrics: ({
        cpu: null, ram_used: 0, ram_total: 0, ram_percent: 0,
        disk_used: 0, disk_total: 0, disk_percent: 0,
        rx_kib: null, tx_kib: null, interface: "", network: "sampling",
        temperature: null
    })
    property var cpuHistory: []

    function recordCpu(value) {
        if (value === null || value === undefined) return;
        var values = root.cpuHistory.slice();
        values.push(Math.max(0, Math.min(100, Number(value))));
        while (values.length > 18) values.shift();
        root.cpuHistory = values;
    }

    function bytesGiB(value) {
        return (Number(value || 0) / 1073741824).toFixed(1) + " GiB";
    }

    function speed(value) {
        if (value === null || value === undefined) return "—";
        var n = Number(value);
        if (n >= 1024) return (n / 1024).toFixed(1) + " MiB/s";
        return n.toFixed(1) + " KiB/s";
    }

    Process {
        id: statsProcess
        command: ["bash", Quickshell.shellPath("scripts/akkad-stats")]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    var result = JSON.parse(this.text);
                    root.metrics = result;
                    root.recordCpu(result.cpu);
                } catch (error) {
                    console.warn("AKKAD telemetry parse failed:", error);
                }
            }
        }
    }

    Timer {
        interval: 3500
        repeat: true
        running: true
        onTriggered: {
            if (!statsProcess.running) statsProcess.running = true;
        }
    }

    ImperialPanel {
        anchors.fill: parent
        inset: 14

        Column {
            anchors.fill: parent
            spacing: 9

            Row {
                width: parent.width
                height: 20
                spacing: 7
                Text {
                    text: "IMPERIAL VITALS"
                    color: Palette.ivory
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 9
                    font.letterSpacing: 1.1
                    anchors.verticalCenter: parent.verticalCenter
                }
                Item { width: 1; height: 1 }
                Rectangle {
                    width: 5
                    height: 5
                    radius: 2.5
                    color: Palette.amber
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Rectangle { width: parent.width; height: 1; color: Palette.line }

            Column {
                width: parent.width
                spacing: 5
                Row {
                    width: parent.width
                    Text { text: "CPU"; color: Palette.gold; font.family: "JetBrainsMono Nerd Font"; font.pixelSize: 9 }
                    Item { width: 1; height: 1 }
                    Text {
                        text: root.metrics.cpu === null ? "SAMPLING" : Number(root.metrics.cpu).toFixed(1) + "%"
                        color: Palette.ivory
                        font.family: "JetBrainsMono Nerd Font"
                        font.pixelSize: 9
                    }
                }
                Item {
                    id: graph
                    width: parent.width
                    height: 29
                    Row {
                        anchors.fill: parent
                        anchors.bottom: parent.bottom
                        spacing: 4
                        Repeater {
                            model: root.cpuHistory
                            delegate: Rectangle {
                                required property var modelData
                                width: Math.max(3, (graph.width - 17 * 4) / 18)
                                height: Math.max(2, graph.height * Number(modelData) / 100)
                                anchors.bottom: parent.bottom
                                radius: 1
                                color: Palette.amber
                                opacity: 0.35 + Math.min(0.65, Number(modelData) / 100)
                            }
                        }
                    }
                }
                Text {
                    text: root.metrics.temperature === null ? "CPU TEMP  ·  NOT EXPOSED" : "CPU TEMP  ·  " + root.metrics.temperature + " °C"
                    color: Palette.muted
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 7
                }
            }

            Rectangle { width: parent.width; height: 1; color: Palette.faint }

            Column {
                width: parent.width
                spacing: 5
                Row {
                    width: parent.width
                    Text { text: "MEMORY"; color: Palette.gold; font.family: "JetBrainsMono Nerd Font"; font.pixelSize: 9 }
                    Item { width: 1; height: 1 }
                    Text {
                        text: root.metrics.ram_total > 0 ? root.bytesGiB(root.metrics.ram_used) + " / " + root.bytesGiB(root.metrics.ram_total) : "—"
                        color: Palette.ivory
                        font.family: "JetBrainsMono Nerd Font"
                        font.pixelSize: 8
                    }
                }
                Rectangle {
                    width: parent.width
                    height: 5
                    radius: 2
                    color: Palette.bronze
                    Rectangle {
                        width: parent.width * Math.max(0, Math.min(1, Number(root.metrics.ram_percent) / 100))
                        height: parent.height
                        radius: 2
                        color: Palette.gold
                    }
                }
                Text {
                    text: root.metrics.ram_total > 0 ? Number(root.metrics.ram_percent).toFixed(1) + "% USED" : "WAITING FOR /proc/meminfo"
                    color: Palette.muted
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 7
                }
            }

            Rectangle { width: parent.width; height: 1; color: Palette.faint }

            Column {
                width: parent.width
                spacing: 5
                Row {
                    width: parent.width
                    Text { text: "ROOT STORAGE"; color: Palette.gold; font.family: "JetBrainsMono Nerd Font"; font.pixelSize: 9 }
                    Item { width: 1; height: 1 }
                    Text {
                        text: root.metrics.disk_total > 0 ? Number(root.metrics.disk_percent).toFixed(0) + "%" : "—"
                        color: Palette.ivory
                        font.family: "JetBrainsMono Nerd Font"
                        font.pixelSize: 9
                    }
                }
                Rectangle {
                    width: parent.width
                    height: 5
                    radius: 2
                    color: Palette.bronze
                    Rectangle {
                        width: parent.width * Math.max(0, Math.min(1, Number(root.metrics.disk_percent) / 100))
                        height: parent.height
                        radius: 2
                        color: Palette.sandstone
                    }
                }
                Text {
                    text: root.metrics.disk_total > 0 ? root.bytesGiB(root.metrics.disk_used) + " / " + root.bytesGiB(root.metrics.disk_total) : "DISK DATA UNAVAILABLE"
                    color: Palette.muted
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 7
                }
            }

            Rectangle { width: parent.width; height: 1; color: Palette.faint }

            Column {
                width: parent.width
                spacing: 5
                Row {
                    width: parent.width
                    Text { text: "NETWORK"; color: Palette.gold; font.family: "JetBrainsMono Nerd Font"; font.pixelSize: 9 }
                    Item { width: 1; height: 1 }
                    Text {
                        text: root.metrics.network === "connected" ? root.metrics.interface : "OFFLINE"
                        color: root.metrics.network === "connected" ? Palette.ivory : Palette.muted
                        font.family: "JetBrainsMono Nerd Font"
                        font.pixelSize: 8
                    }
                }
                Row {
                    width: parent.width
                    Text { text: "↓  " + root.speed(root.metrics.rx_kib); color: Palette.sandstone; font.family: "JetBrainsMono Nerd Font"; font.pixelSize: 8 }
                    Item { width: 1; height: 1 }
                    Text { text: "↑  " + root.speed(root.metrics.tx_kib); color: Palette.sandstone; font.family: "JetBrainsMono Nerd Font"; font.pixelSize: 8 }
                }
            }
        }
    }
}
