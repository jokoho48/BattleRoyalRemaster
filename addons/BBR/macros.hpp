#define PREFIX BBR
#define PATH bbr
#define MOD BBR

// define Version Information
#define MAJOR 0
#define MINOR 1
#define PATCHLVL 0
#define BUILD 1

#ifdef VERSION
    #undef VERSION
#endif
#ifdef VERSION_AR
    #undef VERSION_AR
#endif
#define VERSION_AR MAJOR,MINOR,PATCHLVL,BUILD
#define VERSION MAJOR.MINOR.PATCHLVL.BUILD

#define ISDEV

#include "\tc\CLib\addons\CLib\macros.hpp"

#define MFUNC(var) EFUNC(Common,var)
#define QMFUNC(var) QEFUNC(Common,var)
#define MGVAR(var) EGVAR(Common,var)
#define QMGVAR(var) QUOTE(MGVAR(var))

#define GARBAGE(var) var call MFUNC(pushBackToGarbageCollector)

#define RND(var) (round(random 100))<=var
#define NOCLEAN(var) var setVariable [QCGVAR(noClean), true, true]
