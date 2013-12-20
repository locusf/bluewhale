import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"

ApplicationWindow
{
    id: mainWindow
    property string lastNote
    initialPage: Component {
        FirstPage {
            id: page
            Component.onCompleted: mainWindow.page = page
        }
    }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
}


