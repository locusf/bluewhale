#ifndef CACHETESTS_H
#define CACHETESTS_H

#include <QObject>
#include <QtTest/QTest>
#include <QSignalSpy>
#include "cache.h"

class CacheTests : public QObject
{
    Q_OBJECT
public:
    explicit CacheTests(QObject *parent = 0);
    
signals:

public slots:
private slots:
    void initTestCase();
    void cleanupTestCase();

    void testInstance();
    void testSoftLoad();
    void testLoad();
    void testGenGuid();
    void testGetNoteForGuid();
    void testFillWithNotebooks();
    void testFillWithSavedSearch();
private:
    DatabaseManager* dbpoint;
    Cache* m_instance;
};

#endif // CACHETESTS_H
