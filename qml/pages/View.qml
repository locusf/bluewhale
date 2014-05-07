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
                getTags()
            }
        }
        Component.onCompleted: {
            txtTitle.title = targetNote.title
            notearea.loadHtml(Cache.getNoteContent(targetNote))
            notebooktitl.text = Cache.getNotebook(targetNote).name
            getTags()
        }

        Column {
            id: areacol
            width: parent.width
            PageHeader {
                id: txtTitle
                title: "View note"
            }
            Column {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.paddingLarge
                width: parent.width
//                spacing: Theme.paddingSmall
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
                Label {
                    id: tagslbl
                    text: "Tags"
                    visible: tagstitl.text.length
                    color: Theme.secondaryColor
                    font.pixelSize: Theme.fontSizeExtraSmall
                }
                Label {
                    id: tagstitl
                    visible: text.length
                    anchors.left: parent.left
                    anchors.right: parent.right
                    truncationMode: TruncationMode.Fade
                    MouseArea {
                        width: parent.width
                        height: parent.height
                        onClicked: {
                            var dialog = pageStack.push(Qt.resolvedUrl("Tags.qml"), {targetNote: targetNote})
                            dialog.accepted.connect(function(){
                                EvernoteSession.getNoteContentAsync(targetNote)
                            });
                        }
                    }
                }
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
    function getTags(){
        if (targetNote.tagGuids.length !== 0) {
            var i = 0;
            var tags = targetNote.tagGuids
            tagstitl.text = ""
            for (i = 0; i < tags.length; i++) {
                tagstitl.text += Cache.getTagForGuid(tags[i]).name + ", "
            }
            tagstitl.text = tagstitl.text.slice(0,-1)
        }
    }
}
