#include "macros.hpp"
/*
    BBR

    Author: joko // Jonas & BadGuy

    Description:
    Description

    Parameter(s):
    None

    Returns:
    None
*/
private _iconIdle = "";
private _iconProgress = "\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa";
private _condition = {
    alive _target
     && alive CLib_Player
     && !(CLib_Player getVariable [QGVAR(isUnconscious), false])
     && !(_target getVariable [QGVAR(isUnconscious), false])
     && (_target distance CLib_Player < 3)
     && (group _target == group CLib_Player)
};
GVAR(healStartTime) = -1;
GVAR(healDuration) = 5;

private _onStart = {
    params ["_target"];

    _target setVariable [QGVAR(medicalAction), "HEAL", true];
    GVAR(healStartTime) = time;
    CLib_Player playActionNow "medicStart";
};

private _onProgress = {
    CLib_Player playAction "medicStart";
    (time - GVAR(healStartTime)) / GVAR(healDuration);
};

private _onComplete = {
    params ["_target"];

    _target setVariable [QGVAR(medicalAction), "", true];

    if ("FirstAidKit" in items CLib_Player && !("Medikit" in items CLib_Player)) then {
        CLib_Player removeItem "FirstAidKit";
    };
    GVAR(healStartTime) = -1;
    [QGVAR(heal), _target] call CFUNC(targetEvent);

    CLib_Player playAction "medicStop";
};

private _onInterruption = {
    params ["_target"];

    _target setVariable [QGVAR(medicalAction), "", true];
    GVAR(healStartTime) = -1;
    CLib_Player switchAction "medicStop";
};

["VanillaAction", "HealSoldier", _iconIdle, _iconProgress, _condition, _condition, _onStart, _onProgress, _onComplete, _onInterruption] call CFUNC(addHoldAction);
["VanillaAction", "HealSoldierSelf", _iconIdle, _iconProgress, _condition, _condition, _onStart, _onProgress, _onComplete, _onInterruption] call CFUNC(addHoldAction);

[QGVAR(heal), {
    CLib_Player setDamage ((damage CLib_player) - 0.5);
}] call CFUNC(addEventhandler);
