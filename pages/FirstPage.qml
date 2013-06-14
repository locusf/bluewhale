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
                text: title
                x: theme.paddingLarge
            }
            onClicked: {
                console.log("Clicked " + this)
                var selectedNote = this
                var detailspage = Qt.resolvedUrl("Details.qml")
                pageStack.push(detailspage, {targetNote: Cache.getNote(index)}, 0)
                EvernoteSession.getNoteContentAsync(Cache.getNote(index))
            }
        }

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "Add note"
                onClicked: pageStack.push(Qt.resolvedUrl("AddNote.qml"))
            }
        }
        Timer {
            interval: 1
            running: true
            onTriggered: {
                EvernoteSession.authAsync("locusf", "21ter3ww")
                EvernoteSession.syncAsync()
            }

        }
        Connections {
            target: Cache
            onNoteAdded: {
                console.log("Note load ok " + note.title)
                notesmodel.append(note)
            }
        }



        // Tell SilicaFlickable the height of its content.
        contentHeight: childrenRect.height
        

    }
}


