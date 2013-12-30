import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    id: tagspage
    property variant targetNote;
    Timer {
        interval: 1
        running: true
        onTriggered: {
            Cache.fillWithTags()
        }
    }
    function tagInModel(tag) {
        var i = 0;
        for (i = 0; i < targetNote.tagGuids.length; i++) {
            if (tag.guid == targetNote.tagGuids[i]){
                return true
            }
        }

        return false
    }
    Connections {
        target: Cache
        onTagFired: {
            if (!tagInModel(tag)) {
                alltagmodel.append(tag)
            } else {
                enabledmodel.append(tag)
            }
        }
    }

    SilicaFlickable {
        contentHeight: childrenRect.height
        anchors.fill: parent
        DialogHeader {
            acceptText: "Save Tags"
        }
        PullDownMenu {
            MenuItem {
                text: "Help"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("help/Tags.qml"));
                }
            }
            MenuItem {
                text: "Add tag"
                onClicked: {
                    tagfield.visible = true
                    tagfield.forceActiveFocus()
                }
            }
        }
        Column {
            id: tagcol
            anchors.fill: parent
            anchors.topMargin: 4 * Theme.paddingLarge
            Repeater {
                model: ListModel { id: enabledmodel }
                delegate: TextSwitch {
                    text: name
                    checked: true
                    automaticCheck: false
                    onPressAndHold: {
                        alltagmodel.append({name:name, guid:guid})
                        enabledmodel.remove(index)
                    }
                }
            }
            Repeater {
                model: ListModel { id: alltagmodel }
                delegate: TextSwitch {
                    text: "" + name
                    onClicked: {
                        enabledmodel.append({name:name, guid: guid})
                        alltagmodel.remove(index)
                    }
                }
            }
            TextField {
                id: tagfield
                width: parent.width
                visible: false
                Keys.onReturnPressed: {
                    var guid = EvernoteSession.createTag(tagfield.text);
                    alltagmodel.append({name:tagfield.text, guid:guid})
                }
            }
            PushUpMenu {
                MenuItem {
                    text: "Add tag"
                    onClicked: {
                        tagfield.visible = true
                        tagfield.forceActiveFocus()
                    }
                }
            }
        }
    }
    onDone:{
        if (result == DialogResult.Accepted){
            var i = 0;
            var tags = enabledmodel
            var sel = []
            for (i = 0; i < tags.count; i++) {
                sel.push(tags.get(i).guid)
            }
            targetNote.tagGuids = sel
            EvernoteSession.updateNoteTags(targetNote)
            EvernoteSession.syncAsync()
            EvernoteSession.getNoteContentAsync(targetNote)
        }
    }
}
