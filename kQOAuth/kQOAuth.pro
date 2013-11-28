TEMPLATE = lib
QT += network
TARGET = kQOAuth
TARGETPATH = /usr/share/harbour-bluewhale
target.path = $$TARGETPATH
INSTALLS += target
SOURCES += kqoauthmanager.cpp \
    kqoauthrequest.cpp \
    kqoauthutils.cpp \
    kqoauthauthreplyserver.cpp \
    kqoauthrequest_1.cpp \
    kqoauthrequest_xauth.cpp
HEADERS += kqoauthmanager.h \
    kqoauthrequest.h \
    kqoauthrequest_1.h \
    kqoauthrequest_xauth.h \
    kqoauthglobals.h \
    kqoauthrequest_p.h \
    kqoauthmanager_p.h \
    kqoauthauthreplyserver.h \
    kqoauthauthreplyserver_p.h \
    kqoauthutils.h \
    kqoauthrequest_xauth_p.h
