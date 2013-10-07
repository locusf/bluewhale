import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Silica.theme 1.0

Rectangle {
    id: parentrect
    anchors.fill: parent
    Timer {
        interval: 1
        running: true
        onTriggered: {
            Cache.softLoad()
        }
    }
    Timer {
        interval: 900000
        repeat: true
        running: true
        onTriggered: {
            Cache.softLoad()
        }
    }
    CoverActionList {
        CoverAction {
            iconSource: "image://theme/icon-cover-next"
            onTriggered: {
                notesmodel.clear()
                Cache.setNextNotebook()
                Cache.softLoad()
            }
        }

        CoverAction {
            iconSource: "image://theme/icon-cover-sync"
            onTriggered: {
                EvernoteSession.syncAsync()
                Cache.softLoad()
            }
        }
    }

    Connections {
        target: Cache
        onNotebookFired: {
            notebookheader.title = notebook.name
        }

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
            id: notebookheader
        }
        Repeater {
            model: ListModel {id: notesmodel}
            delegate: Item {
                height: childrenRect.height
                Label {
                    width: parent.width
                    text: title
                    font.pixelSize: Theme.fontSizeExtraSmall
                    truncationMode: TruncationMode.Elide
                }
            }
        }
    }
}
