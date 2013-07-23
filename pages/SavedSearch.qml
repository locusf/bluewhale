import QtQuick 1.1
import Sailfish.Silica 1.0
import QtWebKit 1.0

Page {
    id: savedsearch
    SilicaListView {
        anchors.fill: parent
        height: childrenRect.height
        model: ListModel {id: searchmodel}
        header: PageHeader {
            title: "Saved searches"
        }
        ViewPlaceholder {
            enabled: searchmodel.count == 0
            text: "No saved searches"
        }
        PullDownMenu {
            MenuItem {
                text: "Help"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("help/SavedSearch.qml"));
                }
            }
            MenuItem {
                text: "New saved search"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("AddSavedSearch.qml"))
                }
            }
        }

        Timer {
            interval: 1
            running: true
            onTriggered: {
                Cache.fillWithSavedSearches()
            }
        }
        Connections {
            target: Cache
            onSavedSearchFired: {
                searchmodel.append(search);
            }
            onClearSearches: {
                searchmodel.clear()
            }
        }
        delegate: BackgroundItem {
            height: childrenRect.height
            Label {
                id: ntitle
                text: query
                width: parent.width
                truncationMode: TruncationMode.Fade
                font.pixelSize: theme.fontSizeMedium
                anchors {
                    left: parent.left
                    rightMargin: theme.paddingSmall
                }
            }
            Label {
                id: createdlbl
                text: "Name " + name
                font.pixelSize: theme.fontSizeExtraSmall * 3 / 4
                font.italic: true
                width: parent.width
                anchors {
                    top: ntitle.bottom
                    topMargin: 4
                    left: parent.left
                    right: parent.right
                }
            }
            onClicked: {
                pageStack.pop()
                var squery = query.replace("\"","")
                EvernoteSession.searchNotes(squery)
            }
            onPressAndHold: {
                var ssearch = Cache.getSavedSearchForGuid(guid)
                pageStack.push(Qt.resolvedUrl("EditSavedSearch.qml"), {search: ssearch})
            }
        }
    }
}

