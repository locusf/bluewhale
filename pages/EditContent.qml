import QtQuick 1.1
import Sailfish.Silica 1.0


Page {
    id: editpage
    property variant targetNote;
    Timer {
        interval: 1
        running: true
        onTriggered: {
            notearea.text = targetNote.noteContent
        }
    }
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: areacol.height
        PullDownMenu {
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

            TextArea {
                width: parent.width
                id: notearea
            }
        }
    }
}
