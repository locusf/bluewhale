#ifndef OAUTH_H
#define OAUTH_H

#include <QObject>
#include <QtWebKit/QtWebKit>
#include <kQOAuth/kqoauthrequest.h>
#include <kQOAuth/kqoauthmanager.h>
#include <settings.h>

class OAuth : public QObject
{
    Q_OBJECT
public:
    explicit OAuth(QObject *parent = 0);
    ~OAuth();
    void init();
    void deinit();
    static OAuth* instance();
signals:
    void browserAuth(QString url);
    void requestDone();
public slots:
    void getAccess();
    void onTemporaryTokenReceived(QString token, QString tokenSecret);
    void onAuthorizationReceived(QString token, QString verifier);
    void onAccessTokenReceived(QString token, QString store_url);
    void onRequestReady(QByteArray response);
    void onReceivedToken(QString oauth_token, QString oauth_token_secret);
private:
    KQOAuthRequest* mOauthRequest;
    KQOAuthManager* mOauthManager;
    static OAuth* m_instance;
};

#endif // OAUTH_H
