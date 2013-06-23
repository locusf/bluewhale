import QtQuick 1.1
import Sailfish.Silica 1.0


Page {
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: childrenRect.height
        Column {
            width: parent.width
            PageHeader {
                title: "Help: Tags"
            }
            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                text: "In this view you will be modifying a notes tags.<br>To select a tag, tap on the unhighlighted entry for a tag. This results in the tag being added to the top view where the tag is highlighted.<br/>To add a tag, use the pulley menu and select 'Add tag'. This will reveal a text field in which you can add tags by writing text and then pressing 'Enter'. This will add the tag to the unhighlighted list.<br/>To remove a tag from the note, long press the highlighted entry.<br/>To save your modifications, use the pulley menu and select 'Save tags'."
            }
        }
    }
}
