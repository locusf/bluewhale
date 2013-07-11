
#include <QApplication>
#include <QDeclarativeView>

#include <QDeclarativeComponent>
#include <QDeclarativeEngine>
#include <QDeclarativeContext>

#include "sailfishapplication.h"
#include "testrunner.h"
#include "cachetests.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    TestRunner runner;
    runner.addTest(new CacheTests());
    qDebug() << "Testing results: " << (runner.runTests()?"PASS":"FAIL");
    QScopedPointer<QApplication> app(Sailfish::createApplication(argc, argv));
    QScopedPointer<QDeclarativeView> view(Sailfish::createView("main.qml"));
    qmlRegisterType <TagWrapper> ("com.evernote.types",1,0, "Tag");
    qmlRegisterType <NoteWrapper> ("com.evernote.types",1,0, "Note");
    qmlRegisterType <ResourceWrapper> ("com.evernote.types",1,0, "Resource");
    qmlRegisterType <NotebookWrapper> ("com.evernote.types",1,0, "Notebook");
    qmlRegisterType <SavedSearchWrapper> ("com.evernote.types",1,0, "SavedSearch");
    Sailfish::showView(view.data());


    
    return app->exec();
}


