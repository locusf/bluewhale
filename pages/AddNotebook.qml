import QtQuick 1.1
import Sailfish.Silica 1.0


Page {
    id: addnotebookpage

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: childrenRect.height
        PullDownMenu {
            MenuItem {
                text: "Save"
                onClicked: {
                    var notebook = Qt.createQmlObject("import com.evernote.types 1.0; Notebook {}", addnotebookpage)
                    notebook.name = txtTitle.text
                    EvernoteSession.addNotebook(notebook)
                    pageStack.pop()
                    EvernoteSession.sync()
                    Cache.load()
                    Cache.fillWithNotebooks()
                }
            }
        }


        Column {
            width: parent.width
            PageHeader {
                title: "Add notebook"
            }
            Label {
                text: "Name"
            }

            TextField {
                id: txtTitle
                width: parent.width
            }
        }
    }
}
