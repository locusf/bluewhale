import QtQuick 1.1
import Sailfish.Silica 1.0

Page {
    id: tagspage
    property variant targetNote;
    Timer {
        interval: 1
        running: true
        onTriggered: {
            Cache.fillWithTags()

        }
    }

    Connections {
        target: Cache
        onTagFired: {
            var tags = targetNote.tagGuids
            var i = 0;
            for (i = 0; i < tags.length; i++) {
                alltagmodel.append({tag: Cache.getTagForGuid(tags[i]), enabledtag: true})
            }
            alltagmodel.append({tag:tag, enabledtag: false})
        }
    }

    SilicaFlickable {
        anchors.fill: parent
        height: tagcol.height
        PullDownMenu {
            MenuItem {
                text: "foo"
            }
        }

        Button {
            text: "Save tags"
            onClicked: {
                var i = 0;
                var tags = enabledmodel
                var sel = []
                for (i = 0; i < tags.count; i++) {
                    console.log("Got tag " + tags.get(i).name)
                    sel.push(tags.get(i).guid)
                }
                targetNote.tagGuids = sel
                EvernoteSession.updateNoteTags(targetNote)
                pageStack.pop()
                EvernoteSession.syncAsync()
            }
        }


        Column {
            id: tagcol
            PageHeader {
                title: "Tags"
            }

            Repeater {
                model: ListModel { id: enabledmodel }
            }
            Repeater {
                model: ListModel { id: alltagmodel }
                delegate: TextSwitch {
                    text: "" + tag.name
                    enabled: enabledtag
                    onClicked: {
                        enabledmodel.append({name:name, guid: guid})
                    }
                }
            }
        }
    }
}
