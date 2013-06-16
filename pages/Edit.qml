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
                }
            }
        }
        Connections {
            target: EvernoteSession
            onNoteContentDownloaded: {
                txtTitle.text = targetNote.title
                notearea.text = Cache.getNoteContent(targetNote)
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
                horizontalAlignment: left
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
