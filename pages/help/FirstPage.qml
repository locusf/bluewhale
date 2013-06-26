import QtQuick 1.1
import Sailfish.Silica 1.0


Page {
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: childrenRect.height
        VerticalScrollDecorator {}
        Column {
            width: parent.width
            PageHeader {
                title: "Help: Main page"
            }
            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                text: "Welcome to Bluewhale, an Evernote client for SailfishOS."
            }
            SectionHeader {
                text: "Logging in"
            }
            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                text: "To login use the pulley menu and select item 'Login'. More information is on 'Login' pages help view."
            }
            SectionHeader {
                text: "Add or modify notes"
            }
            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                text: "Adding a note is simple, use the pulley menu and select 'Add Note' item.<br />To modify a note, tap it first to open the view of the note. Then tap on the content area to edit the note."
            }
            SectionHeader {
                text: "Removing notes"
            }
            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                text: "Removing notes is as easy as long pressing a note in the main view or tapping and selecting 'Delete' from the pulley menu."
            }

            SectionHeader {
                text: "Searching"
            }
            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                text: "Searching for notes is achieved using the pulley menu and selecting 'Search'. A text field opens up in the top of the notes view. Enter an Evernote qualified or freeform query and press enter to search. <br /> Results of the search will be refreshed to main view. To return to the all note view, select 'Clear search' from the pulley or push menu."
            }
            SectionHeader {
                text: "Saved searches"
            }
            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                text: "All of your saved searches are available within Bluewhale. To select a saved search, use the pulley menu and select 'Saved searches'. You will find more information on saved searches on that pages help view."
            }

            SectionHeader {
                text: "Notebooks"
            }
            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                text: "To select a notebook to view notes from, use the pulley menu and select item 'Notebooks'. You will be presented with a view of all notebooks you currently have. Tap on a notebook to select its notes into the main view."
            }

        }
    }
}
