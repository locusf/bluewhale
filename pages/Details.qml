import QtQuick 1.1
import Sailfish.Silica 1.0
import QtWebKit 1.0

Page {
    id: detailspage
    property variant targetNote;
    SilicaFlickable {
        id: detailsview
        anchors.fill: parent
        contentHeight: column.height + theme.paddingLarge
        Connections {
            target: EvernoteSession
            onNoteContentDownloaded: {
                noteview.html = Cache.getNoteContent(targetNote)
            }
        }
        Column {
            id: column
            width: parent.width
            height: noteview.height
            PageHeader {
                title: targetNote.title
            }
            WebView {
                id: noteview
                preferredWidth: parent.width
                preferredHeight: parent.height
                smooth: false
                scale: 0.9
            }
        }


    }
}





