import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: editpage
    property variant targetNote;
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: parent.height
        RemorsePopup {
            id: deleteRemorse
        }

        PullDownMenu {
            MenuItem {
                text: "Help"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("help/View.qml"));
                }
            }
            MenuItem {
                text: "Attachments"
                onClicked: pageStack.push(Qt.resolvedUrl("Attachments.qml"), {targetNote: targetNote})
            }

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
                text: "Tags"
                onClicked: pageStack.push(Qt.resolvedUrl("Tags.qml"), {targetNote: targetNote})
            }

        }
        Connections {
            target: EvernoteSession
            onNoteContentDownloaded: {
                txtTitle.title = targetNote.title
                notearea.loadHtml(Cache.getNoteContent(targetNote))
                notebooktitl.text = Cache.getNotebook(targetNote).name
            }
        }
        Component.onCompleted: {
            txtTitle.title = targetNote.title
            notearea.loadHtml(Cache.getNoteContent(targetNote))
            notebooktitl.text = Cache.getNotebook(targetNote).name
        }

        Column {
            id: areacol
            width: parent.width
            PageHeader {
                id: txtTitle
                title: "View note"
            }
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: Theme.paddingLarge
            Label {
                text: "Notebook"
                id: notesbox
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeExtraSmall
            }
            Label {
                id: notebooktitl
                width: parent.width
                anchors.left: parent.left
                truncationMode: TruncationMode.Fade
                MouseArea {
                    width: parent.width
                    height: parent.height
                    onClicked: pageStack.push(Qt.resolvedUrl("EditContent.qml"), {targetNote: targetNote})
                }
            }
            Item{
                width: parent.width
                height: Theme.paddingLarge
            }
        }
        SilicaWebView {
            id: notearea
            width: parent.width
            anchors.bottom: parent.bottom
            anchors.top: areacol.bottom
            anchors.topMargin: 2*  Theme.paddingLarge
            anchors.left: parent.left
            anchors.right: parent.right
            MouseArea {
                width: parent.width
                height: parent.height
                onClicked: {
                    var dialog = pageStack.push(Qt.resolvedUrl("EditContent.qml"), {targetNote: targetNote})
                    dialog.accepted.connect(function() {
                        EvernoteSession.getNoteContentAsync(targetNote)
                    })
                }
            }
        }
    }
}
