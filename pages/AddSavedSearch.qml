import QtQuick 1.1
import Sailfish.Silica 1.0


Page {
    id: addsearchpage
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: childrenRect.height
        PullDownMenu {
            MenuItem {
                text: "Save"
                onClicked: {
                    var search = Qt.createQmlObject("import com.evernote.types 1.0; SavedSearch {}", addsearchpage)
                    search.name = txtTitle.text
                    search.query = notearea.text
                    EvernoteSession.addSavedSearch(search)
                    Cache.fireClearSearches()
                    Cache.fillWithSavedSearches()
                    pageStack.pop()
                    EvernoteSession.syncAsync()
                }
            }
        }
        Column {
            id: areacol
            width: parent.width
            PageHeader {
                title: "New Note"
            }
            Label {
                text: "Title"
            }
            TextField {
                id: txtTitle
                width: parent.width
            }
            Label {
                text: "Content"
            }
            TextField {
                id: notearea
                width: parent.width
            }
        }
    }
}
