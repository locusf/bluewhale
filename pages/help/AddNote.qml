import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: childrenRect.height
        Column {
            width: parent.width
            PageHeader {
                title: "Help: Add note"
            }
            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                text: "Use title and content fields to add a note. <br />Use the combobox to select a notebook for the note.<br />Use the pulley menu to save the note."
            }
        }
    }
}
