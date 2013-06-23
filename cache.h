#ifndef CACHE_H
#define CACHE_H
#include "edam/UserStore.h"
#include "edam/UserStore_constants.h"
#include "edam/NoteStore.h"
#include "edam/NoteStore_constants.h"
#include "edam/NoteStore_types.h"
#include "wrappers/tagwrapper.h"
#include "wrappers/notewrapper.h"
#include "wrappers/notebookwrapper.h"
#include "wrappers/savedsearchwrapper.h"
#include "db/databaseconstants.h"
#include "db/databasemanager.h"
#include "settings.h"
#include "evernotesession.h"
#include <QtCore>
#include <QObject>
#include <QStringListModel>
using namespace evernote::edam;
using namespace std;

class Cache : public QObject
{
    Q_OBJECT
public:
    static Cache* instance();
    static Notebook* selectedNotebook();

    Cache(QObject *parent = 0);
    ~Cache();

signals:
    void clearNotes();
    void clearSearches();
    void noteAdded(NoteWrapper* note);
    void tagFired(TagWrapper* tag);
    void notebookFired(NotebookWrapper* notebook);
    void savedSearchFired(SavedSearchWrapper* search);
public slots:
    void load();
    void clear();
    void setSelectedNotebook(QString guid);
    NoteWrapper* getNote(int index);
    void clearFileCache();
    void openTestFileWindow();
    void fillWithTags();
    void fillWithNotebooks();
    void fillWithSavedSearches();
    QString getNoteContent(NoteWrapper* note);
    QString getCacheFileName(NoteWrapper* note);
    NotebookWrapper* getNotebook(NoteWrapper* note);
    NotebookWrapper* getFirstNoteBook();
    NoteWrapper* getNoteForGuid(QString guid);
    TagWrapper* getTagForGuid(QString guid);
    QString genGuid();
    ResourceWrapper* getResourceForNote(NoteWrapper* note, QString guid);
    SavedSearchWrapper* getSavedSearch(int index);
    SavedSearchWrapper* getSavedSearchForGuid(QString guid);
    void setToDefaultNotebook();

    void fireClearNotes();
    void fireNoteAdded(NoteWrapper* note);
    void fireClearSearches();
private:
    static Cache* m_instance;
    static Notebook* m_sel_notebook;
    QVector <Tag>* tags;
    QVector <Notebook>* notebooks;
    QVector <Note>* notes;
    QVector <SavedSearch>* searches;
};

#endif // CACHE_H
