import QtQuick 1.1
import Sailfish.Silica 1.0

Rectangle {
    anchors.fill: parent
    color: "steelblue"
    opacity: 0.55
    Timer {
        interval: 1
        running: true
        onTriggered: {
            Cache.load()
        }
    }
    Connections {
        target: Cache
        onClearNotes: {
            notesmodel.clear()
        }
        onNoteAdded: {
            notesmodel.append(note)
        }
    }
    Column {
        id: notescol
        width: parent.width
        PageHeader {
            title: "Bluewhale"
        }
        Repeater {
            model: ListModel {id: notesmodel}
            delegate: Item {
                height: childrenRect.height
                Label {
                    width: parent.width
                    text: title
                    truncationMode: TruncationMode.Fade
                }
            }
        }
    }
}
