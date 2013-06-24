import QtQuick 1.1
import Sailfish.Silica 1.0

Rectangle {
    id: parentrect
    anchors.fill: parent
    color: "steelblue"
    gradient: Gradient {
        GradientStop { position: 0.0; color: "lightsteelblue" }
        GradientStop { position: 1.0; color: "steelblue" }
    }
    Timer {
        interval: 1
        running: true
        onTriggered: {
            Cache.load()
        }
    }
    CoverActionList {
        CoverAction {
            iconSource: "image://theme/icon-cover-next"
            onTriggered: {
                console.log(notesmodel.count)
                notesmodel.clear()
                Cache.setNextNotebook()
                Cache.load()
            }
        }

        CoverAction {
            iconSource: "image://theme/icon-cover-sync"
            onTriggered: {
                EvernoteSession.syncAsync()
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
                width: parent.width
                Label {
                    width: parent.width
                    text: title
                    font.pixelSize: theme.fontSizeExtraSmall
                    truncationMode: TruncationMode.Elide
                }
            }
        }
    }
}
