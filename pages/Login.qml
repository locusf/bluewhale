import QtQuick 2.0
import Sailfish.Silica 1.0

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
            MenuItem {
                text: "Log out"
                onClicked: {
                    EvernoteSession.logoutAsync()
                    pageStack.pop()
                    EvernoteSession.syncAsync()
                }
            }
        }

        Timer {
            interval: 1
            running: true
            onTriggered: {
                OAuth.getAccess()
            }
        }
        Connections {
            target: OAuth
            onBrowserAuth: {
                oauthview.url = url
            }
            onRequestDone: {
                pageStack.pop()
                EvernoteSession.recreateSyncClient(true);
                EvernoteSession.recreateUserStoreClient(true);
                EvernoteSession.syncAsync()
            }
        }

        Column {
            id: login
            width: parent.width

            PageHeader {
                title: "Evernote login"
                id: head
            }

            SilicaWebView {
                id: oauthview
                width: parent.width
                height: 500
                objectName: "oauthviewer"
            }
        }
    }
}
