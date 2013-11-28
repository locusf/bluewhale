TEMPLATE = lib
TARGET = thrift
TARGETPATH = /usr/share/harbour-bluewhale
target.path = $$TARGETPATH
INSTALLS += target
INCLUDEPATH += $$PWD $$PWD/../thrift
SOURCES += Thrift.cpp \
    TApplicationException.cpp \
    async/TAsyncProtocolProcessor.cpp \
    async/TAsyncChannel.cpp \
    concurrency/Util.cpp \
    concurrency/TimerManager.cpp \
    concurrency/ThreadManager.cpp \
    concurrency/PosixThreadFactory.cpp \
    concurrency/Mutex.cpp \
    concurrency/Monitor.cpp \
    processor/PeekProcessor.cpp \
    protocol/TJSONProtocol.cpp \
    protocol/TDenseProtocol.cpp \
    protocol/TDebugProtocol.cpp \
    protocol/TCompactProtocol.tcc \
    protocol/TBinaryProtocol.tcc \
    protocol/TBase64Utils.cpp \
    transport/TZlibTransport.cpp \
    transport/TTransportUtils.cpp \
    transport/TTransportException.cpp \
    transport/TSocketPool.cpp \
    transport/TSocket.cpp \
    transport/TSimpleFileTransport.cpp \
    transport/THttpTransport.cpp \
    transport/THttpServer.cpp \
    transport/THttpClient.cpp \
    transport/TFileTransport.cpp \
    transport/TFDTransport.cpp \
    transport/TBufferTransports.cpp

HEADERS += TReflectionLocal.h \
    TProcessor.h \
    TLogging.h \
    Thrift.h \
    TApplicationException.h \
    async/TEvhttpClientChannel.h \
    async/TAsyncProtocolProcessor.h \
    async/TAsyncProcessor.h \
    async/TAsyncChannel.h \
    async/TAsyncBufferProcessor.h \
    concurrency/Util.h \
    concurrency/TimerManager.h \
    concurrency/ThreadManager.h \
    concurrency/Thread.h \
    concurrency/PosixThreadFactory.h \
    concurrency/Mutex.h \
    concurrency/Monitor.h \
    concurrency/FunctionRunner.h \
    concurrency/Exception.h \
    processor/StatsProcessor.h \
    processor/PeekProcessor.h \
    protocol/TVirtualProtocol.h \
    protocol/TProtocolTap.h \
    protocol/TProtocolException.h \
    protocol/TProtocol.h \
    protocol/TJSONProtocol.h \
    protocol/TDenseProtocol.h \
    protocol/TDebugProtocol.h \
    protocol/TCompactProtocol.h \
    protocol/TBinaryProtocol.h \
    protocol/TBase64Utils.h \
    transport/TZlibTransport.h \
    transport/TVirtualTransport.h \
    transport/TTransportUtils.h \
    transport/TTransportException.h \
    transport/TTransport.h \
    transport/TSSLSocket.h \
    transport/TSSLServerSocket.h \
    transport/TSocketPool.h \
    transport/TSocket.h \
    transport/TSimpleFileTransport.h \
    transport/TShortReadTransport.h \
    transport/TServerTransport.h \
    transport/TServerSocket.h \
    transport/THttpTransport.h \
    transport/THttpServer.h \
    transport/THttpClient.h \
    transport/TFileTransport.h \
    transport/TFDTransport.h \
    transport/TBufferTransports.h
