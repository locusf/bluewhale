import QtQuick 1.1
import Sailfish.Silica 1.0


Page {
    id: page
    
    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaListView {
        anchors.fill: parent
        header: PageHeader {
            title: "Bluewhale"
        }

        ListModel {
            id: notesmodel
        }
        model: notesmodel
        delegate: BackgroundItem {
            Label {
                id: ntitle
                text: title
                width: parent.width
                truncationMode: TruncationMode.Fade
                font.pixelSize: theme.fontSizeMedium
                anchors {
                    left: parent.left
                    rightMargin: theme.paddingSmall
                }
            }
            Label {
                text: "Created on " + dateCreated
                font.pixelSize: theme.fontSizeExtraSmall * 3 / 4
                font.italic: true
                anchors {
                    top: ntitle.bottom
                    topMargin: 4
                    left: parent.left
                    right: parent.right
                }
            }

            onClicked: {
                var detailspage = Qt.resolvedUrl("Details.qml")
                var note = Cache.getNote(index)
                pageStack.push(detailspage, {targetNote: note}, 0)
                EvernoteSession.getNoteContentAsync(note)
            }
            onPressAndHold: {
                var editpage = Qt.resolvedUrl("Edit.qml")
                var note = Cache.getNote(index)
                pageStack.push(editpage, {targetNote: note}, 0)
                EvernoteSession.getNoteContentAsync(note)
            }
        }

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "Login"
                onClicked: pageStack.push(Qt.resolvedUrl("Login.qml"))
            }

            MenuItem {
                text: "Sync"
                onClicked: EvernoteSession.syncAsync()
            }
            MenuItem {
                text: "Add note"
                onClicked: pageStack.push(Qt.resolvedUrl("AddNote.qml"))
            }
        }
        Timer {
            interval: 1
            running: true
            onTriggered: {
                EvernoteSession.syncAsync()
            }

        }
        Connections {
            target: Cache
            onClearNotes: {
                notesmodel.clear()
            }

            onNoteAdded: {
                console.log("Note load ok " + note.title)
                notesmodel.append(note)
            }
        }



        // Tell SilicaFlickable the height of its content.
        contentHeight: childrenRect.height
        

    }
}


