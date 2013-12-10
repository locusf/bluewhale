import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: editpage
    property variant targetNote;
    SilicaListView {
        anchors.fill: parent
        height: childrenRect.height
        model: ListModel {id: attachmodel}
        header: PageHeader {
            title: "Attachments"
        }
        ViewPlaceholder {
            enabled: attachmodel.count == 0
            text: "No attachments for this note"
        }

        delegate: BackgroundItem {
            height: childrenRect.height
            Label {
                id: ntitle
                text: "File name " + filename
                width: parent.width
                truncationMode: TruncationMode.Fade
                font.pixelSize: theme.fontSizeMedium
                anchors {
                    left: parent.left
                    rightMargin: theme.paddingSmall
                }
            }
            Label {
                id: createdlbl
                text: "Size " + size + " bytes"
                font.pixelSize: theme.fontSizeExtraSmall * 3 / 4
                font.italic: true
                width: parent.width
                anchors {
                    top: ntitle.bottom
                    topMargin: 4
                    left: parent.left
                    right: parent.right
                }
            }
            onClicked: {
                console.log(guid)
            }
        }
        Timer {
            interval: 1
            running: true
            onTriggered: {
                var i = 0
                for (i = 0; i < targetNote.resources.length; i++) {
                    attachmodel.append(Cache.getResourceForNote(targetNote, targetNote.resources[i]))
                }
            }
        }
    }
}
