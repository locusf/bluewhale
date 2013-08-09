import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: childrenRect.height
        Column {
            width: parent.width
            PageHeader {
                title: "Help: View note"
            }
            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                text: "This view will give the basic information about a note, such as its title, notebook, tags and content it has.<br>To edit a note, tap on the content area.<br>To edit tags of a note, either tap on the tags it already has or use the pulley menu and select 'Tags'."
            }
        }
    }
}
