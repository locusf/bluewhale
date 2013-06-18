import QtQuick 1.1
import Sailfish.Silica 1.0


Page {
    id: page
    
    SilicaListView {
        anchors.fill: parent
        contentHeight: childrenRect.height
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
                var editpage = Qt.resolvedUrl("View.qml")
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
                notesmodel.append(note)
            }
        }
    }
}


