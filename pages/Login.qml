import QtQuick 1.1
import Sailfish.Silica 1.0
import QtWebKit 1.0

Page {
    id: editpage
    property variant targetNote;
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: login.height

        PullDownMenu {
            MenuItem {
                text: "Save login"
                onClicked: {
                    OAuth.getAccess(oauthview)
                }
            }
        }

        Column {
            id: login
            width: parent.width
            PageHeader {
                title: "Login"
            }
            WebView {
                id: oauthview
                objectName: "oauthviewer"
                width: parent.width
            }
        }
    }
}
