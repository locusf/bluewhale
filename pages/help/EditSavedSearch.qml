import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: childrenRect.height
        Column {
            width: parent.width
            PageHeader {
                title: "Help: Edit saved search"
            }
            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                text: "Use name and query fields to modify the selected saved search. <br />Query can be any Evernote search query.<br />Use the pulley menu to save the modified search."
            }
        }
    }
}
