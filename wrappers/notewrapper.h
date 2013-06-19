#ifndef NOTEWRAPPER_H
#define NOTEWRAPPER_H
#include "edam/UserStore.h"
#include "edam/UserStore_constants.h"
#include "edam/NoteStore.h"
#include "edam/NoteStore_constants.h"
#include "edam/NoteStore_types.h"
#include <QVariant>
#include <QObject>
using namespace evernote::edam;
using namespace std;
class NoteWrapper : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString title READ getTitle WRITE setTitle)
    Q_PROPERTY(QString dateCreated READ getDateCreated)
    Q_PROPERTY(bool cached READ isCached)
    Q_PROPERTY(QString noteContent READ getNoteContent WRITE setContent)
    Q_PROPERTY(QString noteContentUrl READ getNoteContentUrl)
    Q_PROPERTY(QString notebookGUID READ getNotebookGUID)
    Q_PROPERTY(QVariantList  tagGuids READ getTagGuids WRITE setTagGuids)
    Q_PROPERTY(QString tagString READ getTagsString)
public:
    explicit NoteWrapper(QObject *parent = 0);
    NoteWrapper(Note note,QObject *parent = 0);
    Note note;
signals:

public slots:
    QString getTitle();
    Guid getGuid();
    QString getDateCreated();
    bool isCached();
    QString getNoteContentUrl();
    QString getNoteContent();
    QString getNotebookGUID();
    QVariantList getTagGuids();
    QString getTagsString();


    void setTitle(QString title);
    void setContent(QString content);
    void setTagGuids(QVariantList tags);

private:

};

#endif // NOTEWRAPPER_H
