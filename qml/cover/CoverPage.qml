import QtQuick 2.0
import Sailfish.Silica 1.0

Rectangle {
    id: parentrect
    anchors.fill: parent
    color: "blue"
    Timer {
        interval: 1
        running: true
        onTriggered: {
            Cache.softLoad()
        }
    }
    Label {
        id: label
        anchors.centerIn: parent
        text: "Bluewhale"
    }
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
    }
}
