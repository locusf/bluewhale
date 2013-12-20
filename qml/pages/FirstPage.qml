import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page
    function clearSearch() {
        Cache.setToDefaultNotebook()
        Cache.load()
    }
    function goToPage(pageName){
        pageStack.push(Qt.resolvedUrl(pageName+".qml"),PageStackAction.Immediate)
    }
    SilicaListView {
        anchors.fill: parent
        id: notesList
        header: PageHeader {
            title: "Bluewhale"
            id: header
            visible: !searchinput.visible
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
            width: parent.width - Theme.paddingLarge * 2
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
                top: parent.top
                topMargin: Theme.paddingSmall
                left: parent.left
                right: parent.right
            }
            Keys.onReturnPressed: {
                EvernoteSession.searchNotes(searchinput.text)
                searchinput.visible = false
                searchinput.text = ""
            }
        }

        delegate: ListItem {
            id: noteListItem
            property Item contextMenu
            ListView.onRemove: animateRemoval()
            height: menuOpen ? contextMenu.height + forPadding.height : forPadding.height
            property bool menuOpen: contextMenu != null && contextMenu.parent === noteListItem
            Item{
                id: forPadding
                height: 80//Theme.itemSizeMedium - Theme.paddingLarge
                anchors.left: parent.left
                anchors.leftMargin: Theme.paddingLarge
                anchors.right: parent.right
                anchors.rightMargin: Theme.paddingLarge
                Label {
                    id: ntitle
                    text: title
                    truncationMode: TruncationMode.Fade
                    font.pixelSize: Theme.fontSizeMedium
                    anchors {
                        top: parent.top
                        topMargin: Theme.paddingSmall
                        left: parent.left
                        leftMargin: Theme.paddingSmall
                        rightMargin: Theme.paddingSmall
                    }
                }
                Label {
                    id: createdlbl
                    text: "Created on " + dateCreated
                    font.pixelSize: Theme.fontSizeExtraSmall * 3 / 4
                    font.italic: true
                    anchors {
                        top: parent.top
                        topMargin: Theme.paddingSmall
                        right: parent.right
                    }
                }
                Label {
                    id: taglbl
                    text: tagString=="No tags"?"":tagString
                    font.italic: true
                    font.pixelSize: Theme.fontSizeExtraSmall * 3 / 4
                    color: Theme.secondaryColor
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
                    font.pixelSize: Theme.fontSizeExtraSmall * 3 / 4
                    color: Theme.secondaryColor
                    width: parent.width
                    truncationMode: TruncationMode.Fade
                    horizontalAlignment: Text.AlignRight
                    anchors {
                        right: parent.right
                        top: createdlbl.bottom
                    }
                }
            }
            function clickItem() {
                var editpage = Qt.resolvedUrl("View.qml")
                var note = Cache.getNoteForGuid(guid)
                pageStack.push(editpage, {targetNote: note}, 0)
                EvernoteSession.getNoteContentAsync(note)
            }
            onClicked: {
                clickItem()
            }
            onPressAndHold: {
                if (!contextMenu)
                    contextMenu = contextMenuComponent.createObject(notesList)
                contextMenu.show(noteListItem)
            }

            Component {
                id: contextMenuComponent
                ContextMenu {
                    MenuItem {
                        text: "Edit"
                        onClicked: {
                            var targetNote = Cache.getNoteForGuid(guid)
                            pageStack.push(Qt.resolvedUrl("EditContent.qml"), {targetNote: targetNote})
                        }
                    }
                    MenuItem {
                        text: "View"
                        onClicked: {
                            clickItem()
                        }
                    }
                    MenuItem {
                        text: "Delete"
                        onClicked: {
                            remorseAction("Deleting", function() { notesmodel.remove(index) })
                        }
                    }

                }
            }
        }

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {

            MenuItem {
                text: "Login"
                onClicked: pageStack.push(Qt.resolvedUrl("Login.qml"))
            }
            MenuItem {
                text: "Help"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("help/FirstPage.qml"));
                }
            }
            MenuItem {
                text: "Clear search"
                onClicked: clearSearch()
            }
            MenuItem {
                text: "Saved searches"
                onClicked: pageStack.push(Qt.resolvedUrl("SavedSearch.qml"))
            }
            MenuItem {
                text: "Search"
                onClicked: {
                    searchinput.visible = true
                    searchinput.forceActiveFocus()
                }
            }
            MenuItem {
                text: "Notebooks"
                onClicked: pageStack.push(Qt.resolvedUrl("ViewNoteBooks.qml"))
            }
            MenuItem {
                text: "Sync"
                onClicked: EvernoteSession.syncAsync()
            }
            MenuItem {
                text: "Add note"
                onClicked: pageStack.push(Qt.resolvedUrl("AddNote.qml"))
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


