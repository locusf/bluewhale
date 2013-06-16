import QtQuick 1.1
import Sailfish.Silica 1.0


Page {
    id: addpage
    SilicaFlickable {
        anchors.fill: parent
        height: areacol.height
        PullDownMenu {
            MenuItem {
                text: "Save"
                onClicked: {
                    var note = Qt.createQmlObject("import com.evernote.types 1.0; Note {}", addpage)
                    note.title = txtTitle.text
                    note.noteContent = notearea.text
                    EvernoteSession.addNote(note)
                }
            }
        }
        Column {
            id: areacol
            width: parent.width
            PageHeader {
                title: "New Note"
            }
            Label {
                text: "Title"
            }
            TextField {
                id: txtTitle
                width: parent.width
            }
            Label {
                text: "Content"
            }
            TextArea {
                id: notearea
                width: parent.width
            }
        }
    }
}
