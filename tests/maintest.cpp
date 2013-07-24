#include "testrunner.h"
#include "cachetests.h"

int main()
{
    TestRunner runner;
    runner.addTest(new CacheTests());
    qDebug() << "Testing results: " << (runner.runTests()?"PASS":"FAIL");
}
