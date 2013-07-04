#ifndef NOTEWRAPPER_H
#define NOTEWRAPPER_H
#include "edam/UserStore.h"
#include "edam/UserStore_constants.h"
#include "edam/NoteStore.h"
#include "edam/NoteStore_constants.h"
#include "edam/NoteStore_types.h"
#include <QVariant>
#include <QObject>
#include <QDateTime>

using namespace evernote::edam;
using namespace std;
class NoteWrapper : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString title READ getTitle WRITE setTitle)
    Q_PROPERTY(QString dateCreated READ getDateCreated)
    Q_PROPERTY(QString guid READ getGuidString)
    Q_PROPERTY(bool cached READ isCached)
    Q_PROPERTY(QString noteContent READ getNoteContent WRITE setContent)
    Q_PROPERTY(QString noteContentUrl READ getNoteContentUrl)
    Q_PROPERTY(QString notebookGUID READ getNotebookGUID WRITE setNotebookGUID)
    Q_PROPERTY(QString notebookName READ getNotebookName)
    Q_PROPERTY(QVariantList  tagGuids READ getTagGuids WRITE setTagGuids)
    Q_PROPERTY(QString tagString READ getTagsString)
    Q_PROPERTY(QVariantList resources READ getResources)
    Q_PROPERTY(QDateTime reminder READ getReminderDate WRITE setReminderDate)
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
    QString getNotebookName();
    QVariantList getTagGuids();
    QString getTagsString();
    QVariantList getResources();
    QString getGuidString();
    QDateTime getReminderDate();

    void setTitle(QString title);
    void setContent(QString content);
    void setTagGuids(QVariantList tags);
    void setNotebookGUID(QString guid);
    void setReminderDate(QDateTime reminder);

private:

};

#endif // NOTEWRAPPER_H
