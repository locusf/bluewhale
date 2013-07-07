import QtQuick 1.1
import Sailfish.Silica 1.0
import QtWebKit 1.0

Page {
    id: notebooks
    SilicaListView {
        anchors.fill: parent
        height: childrenRect.height
        model: ListModel {id: notebookmodel}
        header: PageHeader {
            title: "Notebooks"
        }
        PullDownMenu {
            MenuItem {
                text: "Help"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("help/ViewNotebooks.qml"));
                }
            }
            MenuItem {
                text: "New notebook"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("AddNotebook.qml"))
                }
            }
        }

        delegate: BackgroundItem {
            Label {
                text: name
            }
            onClicked: {
                Cache.setSelectedNotebook(guid)
                pageStack.pop()
                Cache.load()
            }
        }

        ViewPlaceholder {
            enabled: notebookmodel.count == 0
            text: "No notebooks available"
        }
        Connections {
            target: Cache
            onNotebookFired: {
                notebookmodel.append(notebook)
            }
        }
        Component.onCompleted: {
            Cache.fillWithNotebooks()
        }
    }
}
