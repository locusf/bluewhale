import QtQuick 1.1
import Sailfish.Silica 1.0

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
                    Settings.setUsername(userfield.text)
                    Settings.setPassword(passwdfield.text)
                    pageStack.pop()
                    EvernoteSession.authAsync(userfield.text, passwdfield.text)
                    EvernoteSession.syncAsync()
                }
            }
        }

        Column {
            id: login
            width: parent.width
            PageHeader {
                title: "Login"
            }
            Label {
                text: "User name"
            }
            TextField {
                id: userfield
                width: parent.width
            }
            Label {
                text: "Password"
            }
            TextField {
                id:passwdfield
                width: parent.width
                echoMode: TextInput.Password
            }
        }
    }
}
