import QtQuick 1.1
import Sailfish.Silica 1.0


Page {
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: childrenRect.height
        Column {
            width: parent.width
            PageHeader {
                title: "Help: Edit content"
            }
            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                text: "Use title field and content text area to edit a note <br />NB: Only page breaks are formatted, the content is saved as plain text.<br />Use the pulley menu to save your modifications."
            }
        }
    }
}
