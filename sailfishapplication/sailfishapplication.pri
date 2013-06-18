QT += declarative sql network webkit

SOURCES += $$PWD/sailfishapplication.cpp
HEADERS += $$PWD/sailfishapplication.h
INCLUDEPATH += $$PWD $$PWD/../thrift

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
packagesExist(qdeclarative-boostable) {
    message("Building with qdeclarative-boostable support")
    DEFINES += HAS_BOOSTER
    PKGCONFIG += qdeclarative-boostable
} else {
    warning("qdeclarative-boostable not available; startup times will be slower")
}




