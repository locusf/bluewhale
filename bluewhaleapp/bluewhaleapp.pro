TEMPLATE = app
TARGET = harbour-bluewhale

# C++ sources
SOURCES += ../main.cpp \
    ../evernotesession.cpp \
    ../constants/constants.cpp \
    ../db/databasemanager.cpp \
    ../db/databaseconstants.cpp \
    ../constants/settingskeys.cpp \
    ../settings.cpp \
    ../cache.cpp \
    ../wrappers/tagwrapper.cpp \
    ../wrappers/notewrapper.cpp \
    ../fileutils.cpp \
    ../wrappers/resourcewrapper.cpp \
    ../wrappers/notebookwrapper.cpp \
    ../oauth.cpp \
    ../wrappers/savedsearchwrapper.cpp

# C++ headers
HEADERS += ../evernotesession.h \
    ../constants/constants.h \
    ../db/databasemanager.h \
    ../db/databaseconstants.h \
    ../constants/settingskeys.h \
    ../settings.h \
    ../cache.h \
    ../wrappers/tagwrapper.h \
    ../wrappers/notewrapper.h \
    ../fileutils.h \
    ../wrappers/resourcewrapper.h \
    ../wrappers/notebookwrapper.h \
    ../oauth.h \
    ../wrappers/savedsearchwrapper.h

# QML files and folders
qml.files = ../*.qml ../pages ../cover ../main.qml

# The .desktop file
desktop.files = ../harbour-bluewhale.desktop

# Please do not modify the following line.
include(../sailfishapplication/sailfishapplication.pri)
QT += quick qml sql
OTHER_FILES = ../rpm/bluewhale.yaml \
    ../pages/Tags.qml \
    ../pages/View.qml \
    ../README.txt \
    ../LICENCE.txt \
    ../pages/help/SavedSearch.qml \
    ../tests/tests.pri

