import Quickshell 
import Quickshell.Io
import QtQuick 

PanelWindow {
  id: "shell"
  anchors {
    top: true
    left: true
    right: true
  }
  color: '#991b1b1b'
  implicitHeight: 30
  Text {
    padding: 10
    font.family: "Jetbrains Mono"
    color: "#ffffffff"
    id: time
    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter
    Process {
        id: timeProc
        command: ["date", "+%I:%M %p"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: time.text = this.text
        }
    }
  }

  Text {
    padding: 10
    font.family: "Jetbrains Mono"
    color: "#ffffff"
    id: date
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    Process {
        id: dateProc
        command: ["date", "+%m/%d/%Y"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: date.text = this.text
        }
    }
  }

  Text {
    padding: 10
    font.family: "Jetbrains Mono"
    color: '#ffd900'
    id: battery
    anchors.left: parent.left
      anchors.verticalCenter: parent.verticalCenter
    Process {
        id: batteryProc
        command: ["cat", "/sys/class/power_supply/BAT0/capacity"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: battery.text = "BAT: " + this.text
        }
    }
  }

  Text {
    padding: 80
    font.family: "Jetbrains Mono"
    color: '#00eaff'
    id: speaker
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    Process {
        id: speakerProc
        command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: speaker.text = this.text
        }
    }
  }
// wpctl get-volume @DEFAULT_AUDIO_SINK@
  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: timeProc.running = true
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: dateProc.running = true
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: batteryProc.running = true
  }

  Timer {
    interval: 100
    running: true
    repeat: true
    onTriggered: speakerProc.running = true
  }
}