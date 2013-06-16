
#include <QApplication>
#include <QDir>
#include <QGraphicsObject>

#ifdef DESKTOP
#include <QGLWidget>
#endif

#include <QDeclarativeComponent>
#include <QDeclarativeEngine>
#include <QDeclarativeContext>
#include <QDeclarativeView>

#ifdef HAS_BOOSTER
#include <MDeclarativeCache>
#endif

#include "sailfishapplication.h"

QApplication *Sailfish::createApplication(int &argc, char **argv)
{
#ifdef HAS_BOOSTER
    return MDeclarativeCache::qApplication(argc, argv);
#else
    return new QApplication(argc, argv);
#endif
}

QDeclarativeView *Sailfish::createView(const QString &file)
{
    QDeclarativeView *view;
#ifdef HAS_BOOSTER
    view = MDeclarativeCache::qDeclarativeView();
#else
    view = new QDeclarativeView;
#endif
    
    bool isDesktop = qApp->arguments().contains("-desktop");
    
    QString path;
    if (isDesktop) {
        path = qApp->applicationDirPath() + QDir::separator();
#ifdef DESKTOP
        view->setViewport(new QGLWidget);
#endif
    } else {
        path = QString(DEPLOYMENT_PATH);
    }
    view->setSource(QUrl::fromLocalFile(path + file));
    Settings::instance()->setUsername("locusf");
    Settings::instance()->setPassword("21ter3ww");
    Settings::instance()->setAuthToken("S=s1:U=6d5f0:E=14694e4398a:C=13f3d330d8d:P=1cd:A=en-devtoken:V=2:H=1a8d810e83f8f7c88aef93febe041b5f");

    view->rootContext()->setContextProperty("EvernoteSession", EvernoteSession::instance());
    view->rootContext()->setContextProperty("DatabaseManager", DatabaseManager::instance());
    view->rootContext()->setContextProperty("Cache", Cache::instance());
    view->rootContext()->setContextProperty("Settings", Settings::instance());
    return view;
}

void Sailfish::showView(QDeclarativeView* view) {
    view->setResizeMode(QDeclarativeView::SizeRootObjectToView);
    
    bool isDesktop = qApp->arguments().contains("-desktop");
    
    if (isDesktop) {
        view->setFixedSize(480, 854);
        view->rootObject()->setProperty("_desktop", true);
        view->show();
    } else {
        view->setAttribute(Qt::WA_OpaquePaintEvent);
        view->setAttribute(Qt::WA_NoSystemBackground);
        view->viewport()->setAttribute(Qt::WA_OpaquePaintEvent);
        view->viewport()->setAttribute(Qt::WA_NoSystemBackground);
        
        view->showFullScreen();
    }
}


