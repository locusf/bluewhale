import QtQuick 1.1
import Sailfish.Silica 1.0

Page {
    id: editpage
    property variant targetNote;
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: areacol.height

        Connections {
            target: EvernoteSession
            onNoteContentDownloaded: {
                txtTitle.text = targetNote.title
                notearea.text = Cache.getNoteContent(targetNote)
            }
        }

        PullDownMenu {
            MenuItem {
                text: "Save"
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

            TextArea {
                id: notearea
                anchors.top: txtTitle.bottom

            }
        }
    }

}
