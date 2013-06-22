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
        Timer {
            interval: 1
            running: true
            onTriggered: {
                Cache.fillWithNotebooks()
            }
        }
    }
}
