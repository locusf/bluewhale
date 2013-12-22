import QtQuick 2.0
import Sailfish.Silica 1.0


Dialog {
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
                text: "Help"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("help/EditSavedSearch.qml"));
                }
            }
        }
        Column {
            id: areacol
            width: parent.width
            DialogHeader {
                acceptText: "Save Search"
            }
            TextField {
                id: txtTitle
                text: search.name
                placeholderText: title
            }

            TextField {
                width: parent.width
                placeholderText: query
                id: notearea
            }
        }
    }
    onDone: {
        if (result == DialogResult.Accepted){
            search.name = txtTitle.text
            search.query = notearea.text
            EvernoteSession.updateSavedSearch(search)
            EvernoteSession.sync()
            Cache.fireClearSearches()
            Cache.fillWithSavedSearches()
        }
    }
}
