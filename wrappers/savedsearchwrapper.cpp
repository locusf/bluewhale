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
