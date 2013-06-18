# The name of your app
TARGET = bluewhale

# C++ sources
SOURCES += main.cpp \
    edam/UserStore_types.cpp \
    edam/UserStore_constants.cpp \
    edam/UserStore.cpp \
    edam/Types_types.cpp \
    edam/Types_constants.cpp \
    edam/NoteStore_types.cpp \
    edam/NoteStore_constants.cpp \
    edam/NoteStore.cpp \
    edam/Limits_types.cpp \
    edam/Limits_constants.cpp \
    edam/Errors_types.cpp \
    edam/Errors_constants.cpp \
    thrift/Thrift.cpp \
    thrift/TApplicationException.cpp \
    thrift/async/TAsyncProtocolProcessor.cpp \
    thrift/async/TAsyncChannel.cpp \
    thrift/concurrency/Util.cpp \
    thrift/concurrency/TimerManager.cpp \
    thrift/concurrency/ThreadManager.cpp \
    thrift/concurrency/PosixThreadFactory.cpp \
    thrift/concurrency/Mutex.cpp \
    thrift/concurrency/Monitor.cpp \
    thrift/processor/PeekProcessor.cpp \
    thrift/protocol/TJSONProtocol.cpp \
    thrift/protocol/TDenseProtocol.cpp \
    thrift/protocol/TDebugProtocol.cpp \
    thrift/protocol/TCompactProtocol.tcc \
    thrift/protocol/TBinaryProtocol.tcc \
    thrift/protocol/TBase64Utils.cpp \
    thrift/transport/TZlibTransport.cpp \
    thrift/transport/TTransportUtils.cpp \
    thrift/transport/TTransportException.cpp \
    thrift/transport/TSocketPool.cpp \
    thrift/transport/TSocket.cpp \
    thrift/transport/TSimpleFileTransport.cpp \
    thrift/transport/THttpTransport.cpp \
    thrift/transport/THttpServer.cpp \
    thrift/transport/THttpClient.cpp \
    thrift/transport/TFileTransport.cpp \
    thrift/transport/TFDTransport.cpp \
    thrift/transport/TBufferTransports.cpp \
    evernotesession.cpp \
    constants/constants.cpp \
    db/databasemanager.cpp \
    db/databaseconstants.cpp \
    constants/settingskeys.cpp \
    settings.cpp \
    cache.cpp \
    wrappers/tagwrapper.cpp \
    wrappers/notewrapper.cpp \
    fileutils.cpp \
    wrappers/resourcewrapper.cpp \
    wrappers/notebookwrapper.cpp \
    kQOAuth/kqoauthmanager.cpp \
    kQOAuth/kqoauthrequest.cpp \
    kQOAuth/kqoauthutils.cpp \
    kQOAuth/kqoauthauthreplyserver.cpp \
    kQOAuth/kqoauthrequest_1.cpp \
    kQOAuth/kqoauthrequest_xauth.cpp \
    oauth.cpp


# C++ headers
HEADERS += edam/UserStore_constants.h \
    edam/UserStore.h \
    edam/Types_types.h \
    edam/Types_constants.h \
    edam/NoteStore_types.h \
    edam/NoteStore_constants.h \
    edam/NoteStore.h \
    edam/Limits_types.h \
    edam/Limits_constants.h \
    edam/Errors_types.h \
    edam/Errors_constants.h \
    edam/UserStore_types.h \
    thrift/TReflectionLocal.h \
    thrift/TProcessor.h \
    thrift/TLogging.h \
    thrift/Thrift.h \
    thrift/TApplicationException.h \
    thrift/async/TEvhttpClientChannel.h \
    thrift/async/TAsyncProtocolProcessor.h \
    thrift/async/TAsyncProcessor.h \
    thrift/async/TAsyncChannel.h \
    thrift/async/TAsyncBufferProcessor.h \
    thrift/concurrency/Util.h \
    thrift/concurrency/TimerManager.h \
    thrift/concurrency/ThreadManager.h \
    thrift/concurrency/Thread.h \
    thrift/concurrency/PosixThreadFactory.h \
    thrift/concurrency/Mutex.h \
    thrift/concurrency/Monitor.h \
    thrift/concurrency/FunctionRunner.h \
    thrift/concurrency/Exception.h \
    thrift/processor/StatsProcessor.h \
    thrift/processor/PeekProcessor.h \
    thrift/protocol/TVirtualProtocol.h \
    thrift/protocol/TProtocolTap.h \
    thrift/protocol/TProtocolException.h \
    thrift/protocol/TProtocol.h \
    thrift/protocol/TJSONProtocol.h \
    thrift/protocol/TDenseProtocol.h \
    thrift/protocol/TDebugProtocol.h \
    thrift/protocol/TCompactProtocol.h \
    thrift/protocol/TBinaryProtocol.h \
    thrift/protocol/TBase64Utils.h \
    thrift/transport/TZlibTransport.h \
    thrift/transport/TVirtualTransport.h \
    thrift/transport/TTransportUtils.h \
    thrift/transport/TTransportException.h \
    thrift/transport/TTransport.h \
    thrift/transport/TSSLSocket.h \
    thrift/transport/TSSLServerSocket.h \
    thrift/transport/TSocketPool.h \
    thrift/transport/TSocket.h \
    thrift/transport/TSimpleFileTransport.h \
    thrift/transport/TShortReadTransport.h \
    thrift/transport/TServerTransport.h \
    thrift/transport/TServerSocket.h \
    thrift/transport/THttpTransport.h \
    thrift/transport/THttpServer.h \
    thrift/transport/THttpClient.h \
    thrift/transport/TFileTransport.h \
    thrift/transport/TFDTransport.h \
    thrift/transport/TBufferTransports.h \
    evernotesession.h \
    constants/constants.h \
    db/databasemanager.h \
    db/databaseconstants.h \
    constants/settingskeys.h \
    settings.h \
    cache.h \
    wrappers/tagwrapper.h \
    wrappers/notewrapper.h \
    fileutils.h \
    wrappers/resourcewrapper.h \
    wrappers/notebookwrapper.h \
    kQOAuth/kqoauthmanager.h \
    kQOAuth/kqoauthrequest.h \
    kQOAuth/kqoauthrequest_1.h \
    kQOAuth/kqoauthrequest_xauth.h \
    kQOAuth/kqoauthglobals.h \
    kQOAuth/kqoauthrequest_p.h \
    kQOAuth/kqoauthmanager_p.h \
    kQOAuth/kqoauthauthreplyserver.h \
    kQOAuth/kqoauthauthreplyserver_p.h \
    kQOAuth/kqoauthutils.h \
    kQOAuth/kqoauthrequest_xauth_p.h \
    oauth.h


# QML files and folders
qml.files = *.qml pages cover main.qml

# The .desktop file
desktop.files = bluewhale.desktop

# Please do not modify the following line.
include(sailfishapplication/sailfishapplication.pri)

OTHER_FILES = rpm/bluewhale.yaml \
    pages/Tags.qml \
    pages/View.qml \
    README.txt \
    LICENCE.txt
