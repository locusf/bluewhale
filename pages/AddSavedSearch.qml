import QtQuick 1.1
import Sailfish.Silica 1.0


Page {
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
            MenuItem {
                text: "Save"
                onClicked: {
                    var search = Qt.createQmlObject("import com.evernote.types 1.0; SavedSearch {}", addsearchpage)
                    search.name = txtTitle.text
                    search.query = notearea.text
                    EvernoteSession.addSavedSearch(search)
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
                title: "New Saved search"
            }
            Label {
                text: "Name"
            }
            TextField {
                id: txtTitle
                width: parent.width
            }
            Label {
                text: "Query"
            }
            TextField {
                id: notearea
                width: parent.width
            }
        }
    }
}
