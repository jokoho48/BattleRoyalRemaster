#include "macros.hpp"
/*
    BBR

    Author: joko // Jonas

    Description:
    Description

    Parameter(s):
    None

    Returns:
    None
*/
// Hit PP Effects
GVAR(PPRunning) = false;
// Color Correction
GVAR(cc) = ppEffectCreate ["colorCorrections", 1501];
GVAR(cc) ppEffectAdjust [1, 1, 0, [0,0,0,0], [1,1,1,1],[1,1,1,0]];
GVAR(cc) ppEffectEnable true;
GVAR(cc) ppEffectCommit 0;

// Blur
GVAR(blur) = ppEffectCreate ["DynamicBlur", 800];
GVAR(blur) ppEffectAdjust [0];
GVAR(blur) ppEffectCommit 0.3;
GVAR(blur) ppEffectEnable true;

// RBlur
GVAR(rBlur) = ppEffectCreate ["RadialBlur", 1003];
GVAR(rBlur) ppEffectAdjust [0, 0, 0, 0];
GVAR(rBlur) ppEffectCommit 0;
GVAR(rBlur) ppEffectEnable true;

[{
    call FUNC(handleBlur);
}, 0.5] call CFUNC(addPerFrameHandler);

["unconsciousnessChanged", {
    (_this select 0) params ["_state"];
    if !(_state) then {
        GVAR(PPRunning) = false;
        GVAR(cc) ppEffectAdjust [1, 1, 0, [0,0,0,0], [1,1,1,1],[1,1,1,0]];
        GVAR(cc) ppEffectCommit 0;

        // Blur
        GVAR(blur) ppEffectAdjust [0];
        GVAR(blur) ppEffectCommit 0.3;

        // RBlur
        GVAR(rBlur) ppEffectAdjust [0, 0, 0, 0];
        GVAR(rBlur) ppEffectCommit 1;
    };
}] call CFUNC(addEventhandler);
