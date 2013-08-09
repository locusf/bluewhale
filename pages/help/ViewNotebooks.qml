import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: childrenRect.height
        Column {
            width: parent.width
            PageHeader {
                title: "Help: View notebooks"
            }
            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                text: "In this view you can select a notebook for which to display notes from. Simply tap a notebook to do this."
            }
        }
    }
}
