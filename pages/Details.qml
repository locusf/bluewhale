import QtQuick 1.1
import Sailfish.Silica 1.0
import QtWebKit 1.0

Page {
    id: detailspage
    property variant targetNote;
    SilicaFlickable {
        id: detailsview
        anchors.fill: parent
        contentHeight: column.height
        Connections {
            target: EvernoteSession
            onNoteContentDownloaded: {
                noteview.html = Cache.getNoteContent(targetNote)
                console.log("tags " + targetNote.tagGuids)
                var i = 0;
                for (i = 0; i < targetNote.tagGuids.count; i++ )
                {
                    console.log(targetNote.tagGuids.at(i))
                }
            }
        }
        Column {
            id: column
            width: parent.width
            height: noteview.height
            PageHeader {
                title: targetNote.title
            }
            TextField {
                id: tagsfield
                readOnly: true
                width: parent.width
            }

            WebView {
                id: noteview
                preferredWidth: parent.width
                preferredHeight: parent.height
                anchors.top: tagsfield.bottom
                smooth: false
                scale: 0.9
            }
        }


    }
}





