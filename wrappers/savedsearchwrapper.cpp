#include "savedsearchwrapper.h"

SavedSearchWrapper::SavedSearchWrapper(QObject *parent) :
    QObject(parent)
{
}
SavedSearchWrapper::SavedSearchWrapper(SavedSearch ssearch) {
    this->search = ssearch;
}

QString SavedSearchWrapper::getName() {
    return QString::fromStdString(this->search.name);
}

QString SavedSearchWrapper::getQuery() {
    return QString::fromStdString(this->search.query);
}

QString SavedSearchWrapper::getGuid() {
    return QString::fromStdString(this->search.guid);
}

void SavedSearchWrapper::setName(QString name) {
    this->search.name = name.toStdString();
}

void SavedSearchWrapper::setQuery(QString query) {
    this->search.query = query.toStdString();
}
