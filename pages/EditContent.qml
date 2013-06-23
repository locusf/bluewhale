import QtQuick 1.1
import Sailfish.Silica 1.0


Page {
    id: editpage
    property variant targetNote;
    property string selectedNotebookGuid;
    Timer {
        interval: 1
        running: true
        onTriggered: {
            Cache.fillWithNotebooks()
        }
    }
    Connections {
        target: Cache
        onNotebookFired: {
            notebooksmodel.append(notebook)
            if (targetNote.notebookGUID == notebook.guid)
            {
                notesbox.currentIndex = notebooksmodel.count - 1
            }
        }
    }


    SilicaFlickable {
        anchors.fill: parent
        contentHeight: areacol.height
        PullDownMenu {
            MenuItem {
                text: "Help"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("help/EditContent.qml"));
                }
            }
            MenuItem {
                text: "Save"
                onClicked: {
                    targetNote.title = txtTitle.text
                    targetNote.noteContent = notearea.text
                    targetNote.notebookGUID = selectedNotebookGuid
                    EvernoteSession.updateNote(targetNote)
                    pageStack.pop()
                    EvernoteSession.syncAsync()
                    EvernoteSession.getNoteContentAsync(targetNote)
                }
            }
        }
        Column {
            id: areacol
            width: parent.width
            PageHeader {
                title: "Edit note"
            }
            TextField {
                id: txtTitle
                text: targetNote.title
            }

            ComboBox {
                label: "Notebook"
                id: notesbox
                menu: ContextMenu {
                    Repeater {
                        model: ListModel { id: notebooksmodel }
                        MenuItem {
                            text: name
                            onClicked: {
                                selectedNotebookGuid = guid
                            }
                        }
                    }
                }
            }
            TextArea {
                width: parent.width
                text: targetNote.noteContent
                id: notearea
            }
        }
    }
}
