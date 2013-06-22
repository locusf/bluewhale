import QtQuick 1.1
import Sailfish.Silica 1.0


Page {
    id: editsavedsearch
    property variant search;
    Timer {
        interval: 1
        running: true
        onTriggered: {
            notearea.text = search.query
        }
    }
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: areacol.height
        PullDownMenu {
            MenuItem {
                text: "Save"
                onClicked: {
                    search.name = txtTitle.text
                    search.query = notearea.text
                    EvernoteSession.updateSavedSearch(search)
                    pageStack.pop()
                    EvernoteSession.sync()
                    Cache.fireClearSearches()
                    Cache.fillWithSavedSearches()
                }
            }
        }
        Column {
            id: areacol
            width: parent.width
            PageHeader {
                title: "Edit saved search"
            }
            TextField {
                id: txtTitle
                text: search.name
            }

            TextField {
                width: parent.width
                id: notearea
            }
        }
    }
}
