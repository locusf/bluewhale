import QtQuick 1.1
import Sailfish.Silica 1.0

Page {
    id: tagspage
    property variant targetNote;
    Component.onCompleted: {
        Cache.fillWithTags()
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
        PullDownMenu {
            MenuItem {
                text: "Help"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("help/Tags.qml"));
                }
            }
            MenuItem {
                text: "Save tags"
                onClicked: {
                    var i = 0;
                    var tags = enabledmodel
                    var sel = []
                    for (i = 0; i < tags.count; i++) {
                        sel.push(tags.get(i).guid)
                    }
                    targetNote.tagGuids = sel
                    EvernoteSession.updateNoteTags(targetNote)
                    pageStack.pop()
                    EvernoteSession.syncAsync()
                    EvernoteSession.getNoteContentAsync(targetNote)
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
            PageHeader {
                title: "Tags"
            }
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
                height: parent.height
                visible: false
                Keys.onReturnPressed: {
                    var guid = EvernoteSession.createTag(tagfield.text);
                    alltagmodel.append({name:tagfield.text, guid:guid})
                }
            }

        }
    }
}
