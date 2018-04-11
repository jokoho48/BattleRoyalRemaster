#define MODULE KitSpawn
#include "\bbr\BBR\addons\BBR\macros.hpp"

#ifdef ISDEV
    #define CREATEDEBUGMARKER private _mrk = [_pos, nil, nil, nil, str _kit] call MFUNC(createDebugMarker); _mrks pushBack _mrk;
#else
    #define CREATEDEBUGMARKER /*disalbed*/
#endif
#ifdef ISDEV
    #define DEFMARKERSARRAY private _mrks = [];
#else
    #define DEFMARKERSARRAY /*disalbed*/
#endif
