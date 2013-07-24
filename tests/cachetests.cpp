#include "cachetests.h"

CacheTests::CacheTests(QObject *parent) :
    QObject(parent)
{
}


void CacheTests::initTestCase() {
    qRegisterMetaType<NoteWrapper*>("NoteWrapper*");
    qRegisterMetaType<NotebookWrapper*>("NotebookWrapper*");
    qRegisterMetaType<SavedSearchWrapper*>("SavedSearchWrapper*");
    dbpoint = DatabaseManager::instance();
    QSqlDatabase::removeDatabase(DatabaseManager::DB_NAME);
    QSqlDatabase* db = new QSqlDatabase(QSqlDatabase::addDatabase("QSQLITE"));
    db->setDatabaseName("TEST_EVERNOTE");
    db->open();
    dbpoint->setDatabase(db);
    dbpoint->createTables();
    Note testnote;
    testnote.title = "Test note";
    testnote.__isset.title = true;
    dbpoint->saveNote(testnote);
    Notebook test_notebook;
    test_notebook.name = "Test notebook";
    dbpoint->saveNotebook(test_notebook);
    SavedSearch sse;
    sse.name = "Test saved search";
    sse.query = "Test*";
    dbpoint->saveSavedSearch(sse);
    m_instance = Cache::instance();
}

void CacheTests::cleanupTestCase() {
    dbpoint->clear();
    dbpoint->close();
    QSqlDatabase::removeDatabase("TEST_EVERNOTE");
    QSqlDatabase* db = new QSqlDatabase(QSqlDatabase::addDatabase("QSQLITE"));
    db->setDatabaseName(DatabaseManager::DB_NAME);
    db->open();
    dbpoint->setDatabase(db);
}

void CacheTests::testInstance() {
    QVERIFY(Cache::instance() != NULL);
}
void CacheTests::testSoftLoad() {
    m_instance->softLoad();
    QVERIFY(m_instance->getNote(0) == NULL);
}

void CacheTests::testLoad() {
    QSignalSpy spy(m_instance,SIGNAL(noteAdded(NoteWrapper*)));
    m_instance->load();
    QVERIFY(m_instance->getNote(0) != NULL);
    QCOMPARE(spy.count(), 1);
    NoteWrapper* ret = qvariant_cast<NoteWrapper*>(spy.at(0));
    QCOMPARE(ret->getTitle(),"Test note");

}

void CacheTests::testGenGuid() {
    QVERIFY(m_instance->genGuid().length() != 0);
    QRegExp rx("^(\\{){0,1}[0-9a-fA-F]{8}\\-[0-9a-fA-F]{4}\\-[0-9a-fA-F]{4}\\-[0-9a-fA-F]{4}\\-[0-9a-fA-F]{12}(\\}){0,1}$");
    QVERIFY(rx.exactMatch(m_instance->genGuid()));
}

void CacheTests::testGetNoteForGuid() {
    Note note = m_instance->getNote(0)->note;
    Note get_note = m_instance->getNoteForGuid(QString::fromStdString(note.guid))->note;
    QVERIFY(note.guid == get_note.guid);
}

void CacheTests::testFillWithNotebooks() {
    QSignalSpy spy(m_instance, SIGNAL(notebookFired(NotebookWrapper*)));
    m_instance->fillWithNotebooks();
    QCOMPARE(spy.count(), 1);
}

void CacheTests::testFillWithSavedSearch() {
    QSignalSpy spy(m_instance, SIGNAL(savedSearchFired(SavedSearchWrapper*)));
    m_instance->fillWithSavedSearches();
    QCOMPARE(spy.count(), 1);
}
