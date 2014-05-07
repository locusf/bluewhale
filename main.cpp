
#include <QGuiApplication>
#include <QQuickView>
#include <QtQml>
#include "wrappers/notebookwrapper.h"
#include "wrappers/notewrapper.h"
#include "wrappers/resourcewrapper.h"
#include "wrappers/savedsearchwrapper.h"
#include "wrappers/tagwrapper.h"

#include "evernotesession.h"
#include "cache.h"
#include "oauth.h"
#include "settings.h"
#include "db/databasemanager.h"

#include <sailfishapp.h>

int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    qmlRegisterType <TagWrapper> ("com.evernote.types",1,0, "Tag");
    qmlRegisterType <NoteWrapper> ("com.evernote.types",1,0, "Note");
    qmlRegisterType <ResourceWrapper> ("com.evernote.types",1,0, "Resource");
    qmlRegisterType <NotebookWrapper> ("com.evernote.types",1,0, "Notebook");
    qmlRegisterType <SavedSearchWrapper> ("com.evernote.types",1,0, "SavedSearch");
    QScopedPointer<QQuickView> view(SailfishApp::createView());
    view->setSource(SailfishApp::pathTo("qml/harbour-bluewhale.qml"));
    view->rootContext()->setContextProperty("EvernoteSession", EvernoteSession::instance());

    view->rootContext()->setContextProperty("Cache", Cache::instance());
    view->rootContext()->setContextProperty("Settings", Settings::instance());
    view->rootContext()->setContextProperty("OAuth", OAuth::instance());
    view->showFullScreen();
    app->setApplicationName(QString("BlueWhale"));
    app->setOrganizationName(QString("harbour-bluewhale"));
    view->rootContext()->setContextProperty("DatabaseManager", DatabaseManager::instance());
    return app->exec();
}


