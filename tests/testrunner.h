#ifndef TESTRUNNER_H
#define TESTRUNNER_H

#include <QList>
#include <QTimer>
#include <QCoreApplication>
#include <QtTest>

class TestRunner: public QObject
{
    Q_OBJECT

public:
    TestRunner()
        : m_overallResult(0)
    {}

    void addTest(QObject * test) {
        test->setParent(this);
        m_tests.append(test);
    }

    bool runTests() {
        int argc =0;
        char * argv[] = {0};
        QCoreApplication app(argc, argv);
        QTimer::singleShot(0, this, SLOT(run()) );
        app.exec();

        return m_overallResult == 0;
    }
private slots:
    void run() {
        doRunTests();
        QApplication::instance()->quit();
    }
private:
    void doRunTests() {
        foreach (QObject * test, m_tests) {
            m_overallResult|= QTest::qExec(test);
        }
    }

    QList<QObject *> m_tests;
    int m_overallResult;
};

#endif // TESTRUNNER_H
