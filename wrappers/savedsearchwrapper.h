#ifndef SAVEDSEARCHWRAPPER_H
#define SAVEDSEARCHWRAPPER_H

#include "edam/UserStore.h"
#include "edam/UserStore_constants.h"
#include "edam/NoteStore.h"
#include "edam/NoteStore_constants.h"
#include "edam/NoteStore_types.h"
#include <QObject>

using namespace evernote::edam;
class SavedSearchWrapper : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ getName)
    Q_PROPERTY(QString query READ getQuery)
public:
    explicit SavedSearchWrapper(QObject *parent = 0);
    SavedSearchWrapper(SavedSearch ssearch);

signals:
    
public slots:
    QString getName();
    QString getQuery();
private:
    SavedSearch search;
};

#endif // SAVEDSEARCHWRAPPER_H
