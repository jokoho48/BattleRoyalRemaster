#include "macros.hpp"
class CfgPatches {
    class BBR {
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.80;
        author = "joko // Jonas";
        authors[] = {"joko // Jonas"};
        authorUrl = "https://twitter.com/joko48Ger";
        version = VERSION;
        versionStr = QUOTE(VERSION);
        versionAr[] = {VERSION_AR};
        requiredAddons[] = {"CLib"};
    };
};

#include "CfgCLibModules.hpp"

class PRFIX {
};

class CfgCLibSettings {
};
