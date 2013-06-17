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

\
