import QtQuick
import QtQuick.Controls
import Qt.labs.platform
import QuickVLC


ApplicationWindow {
    width: 800
    height: 480
    visible: true
    title: qsTr("QuickVLC example")

    color: "#666666"

    footer: Item {
        height: 32

        Button {
            anchors.left: parent.left
            text: "Open file"
            onClicked: openFileDialog.open()
        }

        Row {
            anchors.centerIn: parent

            Button {
                text: "Play"
                onClicked: player.play()
            }

            Button {
                text: "Pause"
                onClicked: player.pause()
            }

            Button {
                text: "Stop"
                onClicked: player.stop()
            }
        }

        Slider {
            id: volumeControl
            anchors.right: parent.right
            width: 64
            from: 0.0
            to: 1.0
            value: 0.5
        }
    }

    Item {
        id: root

        anchors.fill: parent
        anchors.margins: 24

        Rectangle {
            anchors.fill: parent
            color: "#000000"
        }

        MediaPlayer {
            id: player

            audioOutput: audioOutput
        }

        VideoOutput {
            id: output
            anchors.fill: parent
            source: player
        }

        AudioOutput {
            id: audioOutput
            volume: volumeControl.value
        }
    }

    Shortcut { sequence: "p"; onActivated: player.play() }
    Shortcut { sequence: "s"; onActivated: player.stop() }

    FileDialog {
        id: openFileDialog

        onAccepted: {
            player.source = openFileDialog.file
        }
    }
}
