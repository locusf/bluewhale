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
                txtTitle.text = targetNote.title
                notearea.html = Cache.getNoteContent(targetNote)
                Cache.fillWithNotebooks()
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
        Connections {
            target: Cache
            onNotebookFired: {
                notebooksmodel.append(notebook)
                console.log(notesbox.currentIndex)
                if (targetNote.notebookGUID == notebook.guid)
                {
                    notesbox.currentIndex = notebooksmodel.count - 1
                }
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
            ComboBox {
                label: "Notebook"
                id: notesbox
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
                    color: theme.secondaryColor
                    width: parent.width
                    anchors.left: tagslbl.right + 1
                    truncationMode: TruncationMode.Fade
                    MouseArea {
                        width: parent.width
                        height: parent.height
                        onClicked: pageStack.push(Qt.resolvedUrl("Tags.qml"), {targetNote: targetNote})
                    }
                }
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
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("EditContent.qml"), {targetNote: targetNote})
                    }
                }
            }
        }
    }
}
