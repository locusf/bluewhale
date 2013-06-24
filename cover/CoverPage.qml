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
        width: parent.width
        PageHeader {
            height: childrenRect.height
            title: "Bluewhale"
        }
        Repeater {
            model: ListModel {id: notesmodel}
            delegate: Item {
                height: childrenRect.height
                width: parent.width
                Label {
                    width: parent.width
                    text: title
                    font.pixelSize: theme.fontSizeExtraSmall
                    truncationMode: TruncationMode.Fade
                }
            }
        }
    }
}
