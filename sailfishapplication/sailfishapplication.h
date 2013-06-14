
#ifndef SAILFISHAPPLICATION_H
#define SAILFISHAPPLICATION_H

#include "evernotesession.h"
class QString;
class QApplication;
class QDeclarativeView;

namespace Sailfish {

QApplication *createApplication(int &argc, char **argv);
QDeclarativeView *createView(const QString &);
void showView(QDeclarativeView* view);

}

#endif // SAILFISHAPPLICATION_H

