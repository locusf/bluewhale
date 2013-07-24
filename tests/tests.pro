DEFINES += NO_SAILFISH_MAIN
include(../bluewhaleapp/bluewhaleapp.pro)
SOURCES -= main.cpp
TEMPLATE = app
TARGET = bluewhaletests
TARGETPATH = /opt/sdk/bin
target.path = $$TARGETPATH
INSTALLS += target
#QT -= gui
CONFIG += console
CONFIG -= app_bundle
QT = testlib core sql gui network
INCLUDEPATH += $$PWD/../thrift $$PWD/../edam $$PWD/../
SOURCES += maintest.cpp \
    cachetests.cpp \
    testrunner.cpp
HEADERS += cachetests.h \
    testrunner.h

