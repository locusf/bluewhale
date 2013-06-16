import QtQuick 1.1
import Sailfish.Silica 1.0

Page {
    id: editpage
    property variant targetNote;
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: areacol.height

        RemorsePopup {
            id: deleteRemorse
        }
        PullDownMenu {
            MenuItem {
                text: "Delete"
                onClicked: {
                    deleteRemorse.execute("Deleting", function(){
                        EvernoteSession.deleteNote(targetNote)
                        pageStack.pop()
                        EvernoteSession.syncAsync()
                    }, 2000)
                }
            }
            MenuItem {
                text: "Save"
                onClicked: {
                    targetNote.title = txtTitle.text
                    targetNote.noteContent = notearea.text
                    EvernoteSession.updateNote(targetNote)
                    pageStack.pop()
                    EvernoteSession.syncAsync()
                }
            }
        }
        Connections {
            target: EvernoteSession
            onNoteContentDownloaded: {
                txtTitle.text = targetNote.title
                notearea.text = Cache.getNoteContent(targetNote)
                tagsmenu.show(targetNote.tagGuids)
            }
        }

        Column {
            id: areacol
            width: parent.width
            PageHeader {
                title: targetNote.title
            }

            Label {
                text: "Title"
            }
            TextField {
                id: txtTitle
                width: parent.width
            }
            ComboBox {
                id: tagsbox
                label: "Tags"
                width: parent.width
                menu: ContextMenu {
                    id: tagsmenu
                    MenuItem { text: "automatic" }
                    MenuItem { text: "manual" }
                }
            }

            Label {
                text: "Content"
            }

            TextArea {
                id: notearea
            }
        }
    }

}
