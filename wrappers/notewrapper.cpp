#include "notewrapper.h"
#include <QDate>
#include <QDebug>
#include "fileutils.h"
#include "cache.h"
#include <QVector>
NoteWrapper::NoteWrapper(QObject *parent) :
    QObject(parent)
{
}
NoteWrapper::NoteWrapper(Note note, QObject *parent):QObject(parent){
    this->note  = note;
}
QString NoteWrapper::getTitle(){
    return QString::fromStdString(note.title);

}
Guid NoteWrapper::getGuid(){
    return note.guid;
}
QString NoteWrapper::getGuidString()
{
    return QString::fromStdString(note.guid);
}

QString NoteWrapper::getDateCreated(){
    QDateTime date;
    date.setTime_t(note.created/1000);
    return date.toString("dd/MM/yyyy");
}
bool NoteWrapper::isCached(){
    return FileUtils::noteCached(this);
 }
QString NoteWrapper::getNoteContentUrl(){
    return FileUtils::noteContentFilePath(this);
}
QString NoteWrapper::getNotebookGUID(){
    return QString::fromStdString(note.notebookGuid);
}
QString NoteWrapper::getNotebookName()
{
    return Cache::instance()->getNotebook(this)->getName();
}

QVariantList NoteWrapper::getTagGuids(){
    QVariantList result;
    for(int i=0;i<note.tagGuids.size();i++){
        result.append(QString::fromStdString(note.tagGuids.at(i)));
    }
    return result;
}
void NoteWrapper::setTagGuids(QVariantList tags) {
    note.tagGuids.clear();
    for (int i=0; i < tags.count(); i++) {
        note.tagGuids.push_back(QString(tags.at(i).toString()).toStdString());
    }
}

QString NoteWrapper::getNoteContent() {
    return Cache::instance()->getNoteContent(this);
}

void NoteWrapper::setContent(QString content)
{
    this->note.content = content.toStdString();
}

void NoteWrapper::setTitle(QString title)
{
    this->note.title = title.toStdString();
}

void NoteWrapper::setNotebookGUID(QString guid) {
    this->note.notebookGuid = guid.toStdString();
}

QString NoteWrapper::getTagsString()
{
    QString result;
    if (note.tagGuids.size() == 0) {
        result = "No tags  ";
    } else {
        result = "Tags: ";
    }
    for (int i = 0; i < note.tagGuids.size(); i++)
    {
        result += Cache::instance()->getTagForGuid(QString::fromStdString(note.tagGuids.at(i)))->getName() + ", ";
    }
    result.chop(2);
    return result;
}

QVariantList NoteWrapper::getResources() {
    QVariantList resources;
    for (int i=0; i < note.resources.size(); i++) {
        resources.append(QString::fromStdString(note.resources.at(i).guid));
    }
    return resources;
}

QDateTime NoteWrapper::getReminderDate() {
    return QDateTime::fromMSecsSinceEpoch(abs(this->note.attributes.reminderTime));
}

void NoteWrapper::setReminderDate(QDateTime reminder) {
    this->note.attributes.reminderTime = reminder.toMSecsSinceEpoch();
}

\
