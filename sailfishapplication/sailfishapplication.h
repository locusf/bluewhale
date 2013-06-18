
#ifndef SAILFISHAPPLICATION_H
#define SAILFISHAPPLICATION_H

#include "evernotesession.h"
#include "wrappers/notewrapper.h"
#include "wrappers/notebookwrapper.h"
#include "wrappers/resourcewrapper.h"
#include "wrappers/tagwrapper.h"
#include "oauth.h"

class QString;
class QApplication;
class QDeclarativeView;

namespace Sailfish {

QApplication *createApplication(int &argc, char **argv);
QDeclarativeView *createView(const QString &);
void showView(QDeclarativeView* view);

}

#endif // SAILFISHAPPLICATION_H

