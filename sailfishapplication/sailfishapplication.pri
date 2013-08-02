QT += qml quick sql network webkit concurrent

SOURCES += $$PWD/sailfishapplication.cpp
HEADERS += $$PWD/sailfishapplication.h
INCLUDEPATH += $$PWD $$PWD/../thrift $$PWD/edam $$PWD/../

TARGETPATH = /opt/sdk/bin
target.path = $$TARGETPATH

DEPLOYMENT_PATH = /opt/sdk/share/$$TARGET
qml.path = $$DEPLOYMENT_PATH
desktop.path = /opt/sdk/share/applications

contains(CONFIG, desktop) {
    DEFINES *= DESKTOP
    QT += opengl
}

INSTALLS += target qml desktop

DEFINES += DEPLOYMENT_PATH=\"\\\"\"$${DEPLOYMENT_PATH}/\"\\\"\"

CONFIG += link_pkgconfig
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

INCLUDEPATH += $$PWD/../thrift
DEPENDPATH += $$PWD/../thrift

packagesExist(qdeclarative-boostable) {
    message("Building with qdeclarative-boostable support")
    DEFINES += HAS_BOOSTER
    PKGCONFIG += qdeclarative-boostable
} else {
    warning("qdeclarative-boostable not available; startup times will be slower")
}




