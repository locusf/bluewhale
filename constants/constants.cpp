#include "constants.h"


const std::string Constants::EDAM_HOST = "sandbox.evernote.com";
const std::string Constants::EDAM_USER_ROOT = "/edam/user";
const std::string Constants::EDAM_NOTE_ROOT = "/edam/note/";

Constants::Constants(QObject *parent) :
    QObject(parent)
{
}
