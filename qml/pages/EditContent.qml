import QtQuick 2.0
import Sailfish.Silica 1.0


Dialog {
    id: editpage
    property variant targetNote;
    property string selectedNotebookGuid;
    property date selectedDate;
    property date selectedTime;
    Timer {
        interval: 1
        running: true
        onTriggered: {
            Cache.fillWithNotebooks()
            selectedNotebookGuid = targetNote.notebookGUID
            console.log(targetNote.reminder)
        }
    }
    Connections {
        target: Cache
        onNotebookFired: {
            notebooksmodel.append(notebook)
            if (targetNote.notebookGUID == notebook.guid)
            {
                notesbox.currentIndex = notebooksmodel.count - 1
            }
        }
    }


    SilicaFlickable {
        anchors.fill: parent
        contentHeight: areacol.height
        PullDownMenu {
            MenuItem {
                text: "Help"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("help/EditContent.qml"));
                }
            }
        }

        Column {
            id: areacol
            width: parent.width
            DialogHeader {
                acceptText: "Save Note"
            }
            TextField {
                id: txtTitle
                text: targetNote.title
                placeholderText: "title"
                font.pixelSize: Theme.fontSizeLarge
            }
            ComboBox {
                label: "Notebook"
                id: notesbox
                menu: ContextMenu {
                    Repeater {
                        model: ListModel { id: notebooksmodel }
                        MenuItem {
                            text: name
                            onClicked: {
                                selectedNotebookGuid = guid
                            }
                        }
                    }
                }
            }

            Row {
                anchors.left: parent.left
                anchors.leftMargin: Theme.paddingLarge
                Label {
                    id: remlabel
                    text: "Set reminder"
                }
                Button {
                    anchors.top: remlabel.top
                    anchors.topMargin: - Theme.paddingSmall - 4
                    text: "Time"
                    width: 90
                    onClicked: {
                        var date = targetNote.reminder || new Date()
                        var dialog = pageStack.openDialog("Sailfish.Silica.TimePickerDialog", {
                            hourMode: DateTime.TwentyFourHours,
                            hour: date.getHours(),
                            minute: date.getMinutes()
                        })
                        dialog.accepted.connect(function() {
                            selectedTime = dialog.time
                        })
                    }
                }
                Label {
                    text: "and"
                }
                Button {
                    anchors.top: remlabel.top
                    anchors.topMargin: - Theme.paddingSmall - 4
                    text: "Date"
                    width: 90
                    onClicked: {
                        var date = targetNote.reminder || new Date()

                        var dialog = pageStack.openDialog("Sailfish.Silica.DatePickerDialog", {
                            day: date.getDate(),
                            month: date.getMonth() + 1,
                            year: date.getFullYear()
                        })

                        dialog.accepted.connect(function() {
                            selectedDate = dialog.date
                        })
                    }

                }
            }

            TextArea {
                width: parent.width
                text: targetNote.noteContent
                id: notearea
                background: Rectangle {
                    color: "steelblue"
                }
                Component.onCompleted: {
                    _editor.textFormat = TextEdit.RichText
                }
            }
        }
    }
    onDone: {
        if (result == DialogResult.Accepted){
            targetNote.title = txtTitle.text
            targetNote.noteContent = notearea.text
            targetNote.notebookGUID = selectedNotebookGuid
            var combdate = new Date(selectedDate.getFullYear(),
                                    selectedDate.getMonth(),
                                    selectedDate.getDate(),
                                    selectedTime.getHours(),
                                    selectedTime.getMinutes())
            targetNote.reminder = combdate
            EvernoteSession.updateNote(targetNote)
        }
    }
}
