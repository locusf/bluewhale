import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: childrenRect.height
        PullDownMenu {
            MenuItem {
                text: "Login"
                onClicked: pageStack.push(Qt.resolvedUrl("Login.qml"))
            }
            MenuItem {
                text: "Help"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("help/FirstPage.qml"));
                }
            }
        }
        Column {
            width: parent.width
            PageHeader {
                title: "About"
            }
            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                text: "Author: Aleksi Suomalainen <br/> Co-author: Michael Demetriou <br /> This application is free software."
            }
        }
    }
}
