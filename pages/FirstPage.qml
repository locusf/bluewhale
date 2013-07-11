import QtQuick 1.1
import Sailfish.Silica 1.0


Page {
    id: page
    function clearSearch() {
        Cache.setToDefaultNotebook()
        Cache.load()
    }
    SilicaListView {
        anchors.fill: parent
        contentHeight: childrenRect.height

        header: PageHeader {
            title: "Bluewhale"
            id:header
        }

        RemorsePopup {
            id: deleteRemorse
        }

        Slider {
            id: changingSlider
            value: 30
            minimumValue:0
            maximumValue:100
            enabled: true
            visible: false
            width: parent.width - theme.paddingLarge * 2
            handleVisible: false
            anchors.horizontalCenter: parent.horizontalCenter
        }

        ListModel {
            id: notesmodel
        }
        model: notesmodel
        ViewPlaceholder {
            enabled: notesmodel.count == 0
            text: "No notes for this notebook."
        }

        TextField {
            id: searchinput
            visible: false
            width: parent.width
            anchors {
                top: header.bottom
                left: parent.left
                right: parent.right
            }
            Keys.onReturnPressed: {
                EvernoteSession.searchNotes(searchinput.text)
                searchinput.visible = false
                searchinput.text = ""
            }
        }

        delegate: BackgroundItem {
            height: childrenRect.height
            Label {
                id: ntitle
                text: title
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
                text: "Created on " + dateCreated
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
            Label {
                id: taglbl
                text: tagString
                font.italic: true
                font.pixelSize: theme.fontSizeExtraSmall * 3 / 4
                color: theme.secondaryColor
                width: parent.width
                truncationMode: TruncationMode.Fade
                anchors {
                    top: createdlbl.bottom
                    topMargin: 4
                    left: parent.left
                    right: parent.right
                }
            }
            Label {
                id: notebooklbl
                text: notebookName
                font.italic: true
                font.pixelSize: theme.fontSizeExtraSmall * 3 / 4
                color: theme.secondaryColor
                width: parent.width
                truncationMode: TruncationMode.Fade
                horizontalAlignment: Text.AlignRight
                anchors {
                    left: parent.left
                    right: parent.right
                    top: createdlbl.bottom
                }
            }

            onClicked: {
                var editpage = Qt.resolvedUrl("View.qml")
                var note = Cache.getNoteForGuid(guid)
                pageStack.push(editpage, {targetNote: note}, 0)
                EvernoteSession.getNoteContentAsync(note)
            }
            onPressAndHold: {
                deleteRemorse.execute("Deleting " + title, function(){
                    EvernoteSession.deleteNote(Cache.getNoteForGuid(guid))
                    notesmodel.remove(index)
                })
            }
        }

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "Login"
                onClicked: pageStack.push(Qt.resolvedUrl("Login.qml"))
            }

            MenuItem {
                text: "Saved searches"
                onClicked: pageStack.push(Qt.resolvedUrl("SavedSearch.qml"))
            }
            MenuItem {
                text: "Clear search"
                onClicked: clearSearch()
            }
            MenuItem {
                text: "Notebooks"
                onClicked: pageStack.push(Qt.resolvedUrl("ViewNoteBooks.qml"))
            }
            MenuItem {
                text: "Help"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("help/FirstPage.qml"));
                }
            }
            MenuItem {
                text: "Add note"
                onClicked: pageStack.push(Qt.resolvedUrl("AddNote.qml"))
            }
            MenuItem {
                text: "Search"
                onClicked: {
                    searchinput.visible = true
                    searchinput.forceActiveFocus()
                }
            }
            MenuItem {
                text: "Sync"
                onClicked: EvernoteSession.syncAsync()
            }

        }
        PushUpMenu {
            MenuItem {
                text: "Clear search"
                onClicked: clearSearch()
            }
        }

        Timer {
            interval: 1
            running: true
            onTriggered: {
                EvernoteSession.syncAsync()
            }
        }

        Timer {
            interval: 900000
            repeat: true
            running: true
            onTriggered: {
                EvernoteSession.syncAsync()
            }
        }

        Connections {
            target: Cache
            onClearNotes: {
                notesmodel.clear()
            }

            onNoteAdded: {
                EvernoteSession.getNoteTags(note)
                notesmodel.append(note)
            }
        }
        Connections {
            target: EvernoteSession
            onSyncStarted: {
                changingSlider.visible = true
                changingSlider.value = percent
            }
            onSyncFinished: {
                changingSlider.visible = false
            }
        }
    }
}


