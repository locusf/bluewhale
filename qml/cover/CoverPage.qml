import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    id: parentrect
    Image {
        source: "bluewhale.jpg"
        opacity: 0.3
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectCrop
    }
    Label{
        anchors.centerIn: parent
        text: Cache.getNote(1).title
    }
    Timer {
        interval: 1
        running: true
        onTriggered: {
            Cache.softLoad()
        }
    }
//    Label {
//        id: label
//        anchors.centerIn: parent
//        text: "Bluewhale"
//    }
    Timer {
        interval: 900000
        repeat: true
        running: true
        onTriggered: {
            Cache.softLoad()
        }
    }
    CoverActionList {
        CoverAction {
            iconSource: "image://theme/icon-cover-sync"
            onTriggered: {
                EvernoteSession.syncAsync()
                Cache.softLoad()
            }
        }
        CoverAction {
            iconSource: "image://theme/icon-cover-new"
            onTriggered: {
                mainWindow.activate()
                pageStack.push(Qt.resolvedUrl("../pages/AddNote.qml"),PageStackAction.Immediate);
            }
        }
    }
}
