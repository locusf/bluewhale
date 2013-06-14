import QtQuick 1.1
import Sailfish.Silica 1.0

Page {
    id: page
    SilicaFlickable {
        id: listView
        anchors.fill: parent
        Column {
            Label {
                text: note.title
            }
        }
    }
}





