import QtQuick 1.1
import Sailfish.Silica 1.0


Page {
    id: editpage
    property variant targetNote;
    property string selectedNotebookGuid;
    property int selectedHour;
    property int selectedMinute;
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
            MenuItem {
                text: "Save"
                onClicked: {
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
                    pageStack.pop()
                    EvernoteSession.syncAsync()
                    EvernoteSession.getNoteContentAsync(targetNote)
                }
            }
        }
        Column {
            id: areacol
            width: parent.width
            PageHeader {
                title: "Edit note"
            }
            TextField {
                id: txtTitle
                text: targetNote.title
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
            SectionHeader {
                text: "Reminder"
            }
            Row {
                spacing: 80
                Button {
                    text: "Time"
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
                Button {
                    text: "Date"
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
            }
        }
    }
}
