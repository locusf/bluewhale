
#include <QGuiApplication>
#include <QQuickView>
#include <QtQml>
#include "sailfishapplication.h"
#include "wrappers/notebookwrapper.h"
#include "wrappers/notewrapper.h"
#include "wrappers/resourcewrapper.h"
#include "wrappers/savedsearchwrapper.h"
#include "wrappers/tagwrapper.h"

#include <sailfishapp.h>

int main(int argc, char *argv[])
{
    qmlRegisterType <TagWrapper> ("com.evernote.types",1,0, "Tag");
    qmlRegisterType <NoteWrapper> ("com.evernote.types",1,0, "Note");
    qmlRegisterType <ResourceWrapper> ("com.evernote.types",1,0, "Resource");
    qmlRegisterType <NotebookWrapper> ("com.evernote.types",1,0, "Notebook");
    qmlRegisterType <SavedSearchWrapper> ("com.evernote.types",1,0, "SavedSearch");
    QQuickWindow::setDefaultAlphaBuffer(true);
    QQuickView* view = SailfishApp::createView();
    QGuiApplication* app = SailfishApp::application(argc, argv);
    view->setSource(SailfishApp::pathTo("qml/harbour-bluewhale.qml"));
    view->rootContext()->setContextProperty("EvernoteSession", EvernoteSession::instance());
    view->rootContext()->setContextProperty("DatabaseManager", DatabaseManager::instance());
    view->rootContext()->setContextProperty("Cache", Cache::instance());
    view->rootContext()->setContextProperty("Settings", Settings::instance());
    view->rootContext()->setContextProperty("OAuth", OAuth::instance());
    view->showFullScreen();
    return app->exec();
}


