QT += qml quick sql network concurrent

SOURCES += $$PWD/sailfishapplication.cpp
HEADERS += $$PWD/sailfishapplication.h
INCLUDEPATH += $$PWD $$PWD/../thrift $$PWD/edam $$PWD/../

TARGETPATH = /usr/bin
target.path = $$TARGETPATH

DEPLOYMENT_PATH = /usr/share/$$TARGET
qml.path = $$DEPLOYMENT_PATH
icon.files = ../harbour-bluewhale.png
icon.path = /usr/share/icons/hicolor/86x86/apps
desktop.path = /usr/share/applications

contains(CONFIG, desktop) {
    DEFINES *= DESKTOP
    QT += opengl
}

INSTALLS += target qml desktop icon

DEFINES += DEPLOYMENT_PATH=\"\\\"\"$${DEPLOYMENT_PATH}/\"\\\"\"

CONFIG += link_pkgconfig
PKGCONFIG += sailfishapp
INCLUDEPATH += /usr/include/sailfishapp

LIBS += -lrt -lz
win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../kQOAuth/release/ -lkQOAuth
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../kQOAuth/debug/ -lkQOAuth
else:unix: LIBS += -L$$OUT_PWD/../kQOAuth/ -lkQOAuth

INCLUDEPATH += $$PWD/../kQOAuth
DEPENDPATH += $$PWD/../kQOAuth

win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../edam/release/ -ledam
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../edam/debug/ -ledam
else:unix: LIBS += -L$$OUT_PWD/../edam/ -ledam

INCLUDEPATH += $$PWD/../edam
DEPENDPATH += $$PWD/../edam

win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../thrift/release/ -lthrift
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../thrift/debug/ -lthrift
else:unix: LIBS += -L$$OUT_PWD/../thrift/ -lthrift

unix:!mac{
    QMAKE_LFLAGS += -Wl,-rpath,/usr/share/harbour-bluewhale,-rpath,/opt/sdk/bluewhale/usr/share/bluewhale
    QMAKE_RPATH=
}

INCLUDEPATH += $$PWD/../thrift
DEPENDPATH += $$PWD/../thrift

packagesExist(qdeclarative-boostable) {
    message("Building with qdeclarative-boostable support")
    DEFINES += HAS_BOOSTER
    PKGCONFIG += qdeclarative-boostable
} else {
    warning("qdeclarative-boostable not available; startup times will be slower")
}




