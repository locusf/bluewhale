import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: childrenRect.height
        Column {
            width: parent.width
            PageHeader {
                title: "Help: Login"
            }
            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                text: "Logging into Evernote is simple. You will be presented with a HTML view of the Evernote login page below and you may supply your credentials there. Once logged in you may authorize Bluewhale to access your notebooks and notes. After doing so you will be returned to main view where you can see all your notes."
            }
        }
    }
}
