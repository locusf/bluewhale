import QtQuick 2.0
import Sailfish.Silica 1.0


Dialog {
    id: addsearchpage
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: childrenRect.height
        PullDownMenu {
            MenuItem {
                text: "Help"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("help/AddSavedSearch.qml"));
                }
            }
        }
        Column {
            id: areacol
            width: parent.width
            DialogHeader {
                acceptText: "Save search"
            }
            TextField {
                id: txtTitle
                width: parent.width
                placeholderText: "name"
            }
            TextField {
                id: notearea
                placeholderText: "query"
                width: parent.width
            }
        }
    }
    onDone:{
        if (result == DialogResult.Accepted){
            var search = Qt.createQmlObject("import com.evernote.types 1.0; SavedSearch {}", addsearchpage)
            search.name = txtTitle.text
            search.query = notearea.text
            EvernoteSession.addSavedSearch(search)
            EvernoteSession.sync()
            Cache.fireClearSearches()
            Cache.fillWithSavedSearches()
        }
    }
}
