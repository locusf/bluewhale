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
                text: "Help"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("help/Login.qml"));
                }
            }
        }

        Component.onCompleted: {
            OAuth.getAccess()
        }
        Connections {
            target: OAuth
            onBrowserAuth: {
                oauthview.url = url
            }
            onRequestDone: {
                console.log("Request done!")
                pageStack.pop()
                EvernoteSession.syncAsync()
            }
        }

        Column {
            id: login
            width: parent.width

            PageHeader {
                title: "Evernote login"
            }
            WebView {
                id: oauthview
                objectName: "oauthviewer"
                width: parent.width
                preferredWidth: parent.width
                scale: 0.9
            }
        }
    }
}
