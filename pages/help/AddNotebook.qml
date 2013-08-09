import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: childrenRect.height
        Column {
            width: parent.width
            PageHeader {
                title: "Help: Add notebook"
            }
            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                text: "Use the name field to give the notebook a name.<br />Save the notebook by using the pulley menu."
            }
        }
    }
}
