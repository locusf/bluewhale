
#include <QGuiApplication>
#include <QQuickView>
#include <QtQml>
#include "sailfishapplication.h"
#include "wrappers/notebookwrapper.h"
#include "wrappers/notewrapper.h"
#include "wrappers/resourcewrapper.h"
#include "wrappers/savedsearchwrapper.h"
#include "wrappers/tagwrapper.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    qmlRegisterType <TagWrapper> ("com.evernote.types",1,0, "Tag");
    qmlRegisterType <NoteWrapper> ("com.evernote.types",1,0, "Note");
    qmlRegisterType <ResourceWrapper> ("com.evernote.types",1,0, "Resource");
    qmlRegisterType <NotebookWrapper> ("com.evernote.types",1,0, "Notebook");
    qmlRegisterType <SavedSearchWrapper> ("com.evernote.types",1,0, "SavedSearch");
    QQuickWindow::setDefaultAlphaBuffer(true);
    QScopedPointer<QGuiApplication> app(Sailfish::createApplication(argc, argv));
    QScopedPointer<QQuickView> view(Sailfish::createView("main.qml"));
    
    Sailfish::showView(view.data());
    
    return app->exec();
}


