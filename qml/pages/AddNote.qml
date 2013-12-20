import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: addpage
    property string selectedNotebookGuid;
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: childrenRect.height
        PullDownMenu {
            MenuItem {
                text: "Help"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("help/AddNote.qml"));
                }
            }

            MenuItem {
                text: "Save"
                onClicked: {
                    var note = Qt.createQmlObject("import com.evernote.types 1.0; Note {}", addpage)
                    note.title = txtTitle.text
                    note.noteContent = notearea.text
                    note.notebookGUID = selectedNotebookGuid
                    EvernoteSession.addNote(note)
                    pageStack.pop()
                    EvernoteSession.syncAsync()
                }
            }
        }
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
                if (!selectedNotebookGuid) {
                    selectedNotebookGuid = notebook.guid
                }
            }
        }

        Column {
            id: areacol
            width: parent.width
            PageHeader {
                title: "New Note"
            }
            ComboBox {
                label: ""
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
            TextField {
                id: txtTitle
                width: parent.width
                placeholderText: "title"
                font.pixelSize: 30
            }
            TextArea {
                id: notearea
                width: parent.width
                placeholderText: "content"
            }
        }
    }
}
