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
                notearea.loadHtml(Cache.getNoteContent(targetNote).replace("</body>","<style>body{background:blue}</style></body>"))
                notebooktitl.text = Cache.getNotebook(targetNote).name
                if (targetNote.tagGuids.length !== 0) {
                    tagsrow.visible = true
                    var i = 0;
                    var tags = targetNote.tagGuids
                    tagstitl.text = ""
                    for (i = 0; i < tags.length; i++) {
                        tagstitl.text += Cache.getTagForGuid(tags[i]).name + ","
                    }
                    tagstitl.text = tagstitl.text.slice(0,-1)
                }
            }
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
                    color: Theme.secondaryColor
                    id: notesbox
                    font.pixelSize: Theme.fontSizeExtraSmall
                }
                Label {
                    id: notebooktitl
//                    color: Theme.secondaryColor
                    width: parent.width
                    anchors.left: parent.left
                    truncationMode: TruncationMode.Fade
                    MouseArea {
                        width: parent.width
                        height: parent.height
                        onClicked: pageStack.push(Qt.resolvedUrl("EditContent.qml"), {targetNote: targetNote})
                    }
                }
            }
            Row {
                id: tagsrow
                visible: false
                width: parent.width
                spacing: 80
                Label {
                    id: tagslbl
                    text: "Tags"
                }
                Label {
                    id: tagstitl
                    color: Theme.secondaryColor
                    width: parent.width
//                    anchors.left: tagslbl.right
                    truncationMode: TruncationMode.Fade
                    MouseArea {
                        width: parent.width
                        height: parent.height
                        onClicked: pageStack.push(Qt.resolvedUrl("Tags.qml"), {targetNote: targetNote})
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
                    pageStack.push(Qt.resolvedUrl("EditContent.qml"), {targetNote: targetNote})
                }
            }
        }
    }
}
