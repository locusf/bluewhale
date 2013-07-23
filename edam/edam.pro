TEMPLATE = lib
INCLUDEPATH += ../thrift
TARGET = edam
TARGETPATH = /opt/sdk/bin
target.path = $$TARGETPATH
INSTALLS += target
SOURCES += UserStore_types.cpp \
    UserStore_constants.cpp \
    UserStore.cpp \
    Types_types.cpp \
    Types_constants.cpp \
    NoteStore_types.cpp \
    NoteStore_constants.cpp \
    NoteStore.cpp \
    Limits_types.cpp \
    Limits_constants.cpp \
    Errors_types.cpp \
    Errors_constants.cpp

HEADERS += UserStore_constants.h \
    UserStore.h \
    Types_types.h \
    Types_constants.h \
    NoteStore_types.h \
    NoteStore_constants.h \
    NoteStore.h \
    Limits_types.h \
    Limits_constants.h \
    Errors_types.h \
    Errors_constants.h \
    UserStore_types.h
