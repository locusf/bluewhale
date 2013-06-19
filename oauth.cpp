#include "oauth.h"

OAuth* OAuth::m_instance = NULL;

OAuth::OAuth(QObject *parent) :
    QObject(parent),
    mOauthManager(0),
    mOauthRequest(0)
{
}
void OAuth::init( void )
{
    deinit();
    mOauthRequest = new KQOAuthRequest;
    mOauthManager = new KQOAuthManager(this);
    mOauthRequest->setEnableDebugOutput(true);
    connect(mOauthManager, SIGNAL(receivedToken(QString,QString)),
      this, SLOT(onReceivedToken(QString, QString)));
    connect(mOauthManager, SIGNAL(temporaryTokenReceived(QString,QString)),
      this, SLOT(onTemporaryTokenReceived(QString, QString)));
    connect(mOauthManager, SIGNAL(authorizationReceived(QString,QString)),
      this, SLOT( onAuthorizationReceived(QString, QString)));
    connect(mOauthManager, SIGNAL(accessTokenReceived(QString,QString)),
      this, SLOT(onAccessTokenReceived(QString,QString)));
    connect(mOauthManager, SIGNAL(requestReady(QByteArray)),
      this, SLOT(onRequestReady(QByteArray)));
    connect(mOauthManager, SIGNAL(authorizedRequestDone()),
      this, SLOT(requestDone() ));
}

void OAuth::deinit()
{
    if(mOauthRequest)
    {
      delete mOauthRequest;
      mOauthRequest = 0;
    }
    if(mOauthManager)
    {
      disconnect(mOauthManager, SIGNAL(receivedToken(QString,QString)),
       this, SLOT(onReceivedToken(QString, QString)));
      disconnect(mOauthManager, SIGNAL(temporaryTokenReceived(QString,QString)),
       this, SLOT(onTemporaryTokenReceived(QString, QString)));
      disconnect(mOauthManager, SIGNAL(authorizationReceived(QString,QString)),
       this, SLOT( onAuthorizationReceived(QString, QString)));
      disconnect(mOauthManager, SIGNAL(accessTokenReceived(QString,QString)),
       this, SLOT(onAccessTokenReceived(QString,QString)));
      disconnect(mOauthManager, SIGNAL(requestReady(QByteArray)),
       this, SLOT(onRequestReady(QByteArray)));
      delete mOauthManager;
      mOauthManager = 0;
    }
}

OAuth::~OAuth()
{
    deinit();
}

OAuth* OAuth::instance(){
    if(!m_instance){
        m_instance = new OAuth();
    }
    return m_instance;
}

void OAuth::getAccess()
{
    init();
    QString url = QString("https://sandbox.evernote.com/oauth");
    mOauthRequest->initRequest(KQOAuthRequest::TemporaryCredentials, QUrl(url)); //"https://www.evernote.com/oauth"
    QString consumer_key = "locusf";
    QString consumer_secret = "011e5c43cc39448c";
    mOauthRequest->setConsumerKey(consumer_key);
    mOauthRequest->setConsumerSecretKey(consumer_secret);
    mOauthManager->setHandleUserAuthorization(true);
    if( ! mOauthRequest->isValid() )
    {
      qDebug() << "Invalid request";

    }
    mOauthManager->executeRequest(mOauthRequest);
}

void OAuth::onTemporaryTokenReceived(QString token, QString tokenSecret)
{
    qDebug() << "Temporary token received: " << token << tokenSecret;
    QString url = QString("https://sandbox.evernote.com/OAuth.action");
    QUrl userAuthURL(url);
    if( mOauthManager->lastError() == KQOAuthManager::NoError)
    {
        qDebug() << "Asking for user's permission to access protected resources. Opening URL: " << userAuthURL;
        browserAuth(mOauthManager->getUserAuthorization(userAuthURL).toString());
    }
    else
    {
      qDebug() << "onTemporaryTokenReceived :: OAuth with Evernote failed!";
    }
}
void OAuth::onAuthorizationReceived(QString token, QString verifier)
{
    qDebug() << "User authorization received: " << token << verifier;
    QString url = QString("https://sandbox.evernote.com/oauth");
    mOauthManager->getUserAccessTokens(QUrl(url));
    if( mOauthManager->lastError() != KQOAuthManager::NoError)
    {
        qDebug() << "onAuthorizationReceived :: OAuth with Evernote failed!";
    }
}

void OAuth::onAccessTokenReceived(QString token, QString store_url)
{
    qDebug() << "Access token received: " << token << store_url;
    Settings::instance()->setAuthToken(token);
    qDebug() << "Access tokens now stored!";
}

void OAuth::onRequestReady(QByteArray response)
{
    qDebug() << "Response from the service: " << response;
    QString strresp = response;
    qDebug() << "Clarified response " << strresp;
    if (strresp.lastIndexOf("edam_noteStoreUrl") != -1) {
        QStringList tokens = strresp.split("&");
        QString oauth_token = QUrl::fromPercentEncoding(tokens.at(0).split("=").at(1).toLocal8Bit());
        qDebug() << "Auth token got! " << oauth_token;
        Settings::instance()->setAuthToken(oauth_token);
        requestDone();
    }

    if( response == "" )
    {
      qDebug() << "onRequestReady :: Failed to authorize, empty response from evernote";
    }
}

void OAuth::onReceivedToken( QString oauth_token, QString oauth_token_secret )
{
    qDebug() << "onReceivedToken: " << oauth_token << oauth_token_secret;
}
