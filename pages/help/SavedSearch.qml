import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: childrenRect.height
        Column {
            width: parent.width
            PageHeader {
                title: "Help: Saved search"
            }
            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                text: "Tapping a saved search will refresh the main view by its query results. To add a new saved search use the pulley menu and select 'New saved search'.<br/> To modify a saved search, long press it and an edit view will open up. See its help view for more information."
            }
        }
    }
}
