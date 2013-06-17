import QtQuick 1.1
import Sailfish.Silica 1.0
import QtWebKit 1.0

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

        }
        Connections {
            target: EvernoteSession
            onNoteContentDownloaded: {
                txtTitle.text = targetNote.title
                notearea.html = Cache.getNoteContent(targetNote)
            }
        }

        Column {
            id: areacol
            width: parent.width
            PageHeader {
                title: "View note"
            }

            Label {
                text: "Title"
            }
            TextField {
                id: txtTitle
                width: parent.width
                readOnly: true
            }
            Button {
                text: "Tags"
                onClicked: pageStack.push(Qt.resolvedUrl("Tags.qml"), {targetNote: targetNote})
            }
            Label {
                text: "Content"
            }
            WebView {
                id: notearea
                width: parent.width
                MouseArea {
                    width: parent.width
                    height: parent.height
                    onPressAndHold: {
                        pageStack.push(Qt.resolvedUrl("EditContent.qml"), {targetNote: targetNote})
                    }
                }
            }
        }
    }
}
