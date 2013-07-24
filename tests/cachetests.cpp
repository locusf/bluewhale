#include "cachetests.h"
CacheTests::CacheTests(QObject *parent) :
    QObject(parent)
{
}


void CacheTests::initTestCase() {
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

void CacheTests::testLoad() {
    m_instance->load();
    QVERIFY(m_instance->getNote(0) != NULL);
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
