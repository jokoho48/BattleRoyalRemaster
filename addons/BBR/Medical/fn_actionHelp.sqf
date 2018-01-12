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
private _title = "Help Up";
private _iconIdle = "";
private _iconProgress = "\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa";
private _condition = {
    alive _target
     && alive CLib_Player
     && !(CLib_Player getVariable [QGVAR(isUnconscious), false])
     && (_target getVariable [QGVAR(isUnconscious), false])
     && (_target distance CLib_Player < 3)
     && (group _target == group CLib_Player)
     && ((_target getVariable [QGVAR(medicalAction), ""]) == "")
     && ((CLib_Player getVariable [QGVAR(medicalAction), ""]) == "")
};
GVAR(helpStartTime) = -1;
GVAR(helpDuration) = 6

private _onStart = {
    params ["_target", "_caller"];

    _target setVariable [QGVAR(medicalAction), "HELP", true];
    GVAR(helpStartTime) = time;
    CLib_Player playAction "medicStart";
};

private _onProgress = {
    CLib_Player playAction "medicStart";
    (time - GVAR(helpStartTime)) / GVAR(helpDuration);
};

private _onComplete = {
    params ["_target", "_caller"];

    _target setVariable [QGVAR(medicalAction), "", true];

    GVAR(helpStartTime) = -1;
    [QGVAR(help), _target] call CFUNC(targetEvent);

    CLib_Player playAction "medicStop";
};

private _onInterruption = {
    params ["_target", "_caller"];

    _target setVariable [QGVAR(medicalAction), "", true];
    GVAR(helpStartTime) = -1;
    CLib_Player switchAction "medicStop";
};

["CAManBase", _title, _iconIdle, _iconProgress, _condition, _condition, _onStart, _onProgress, _onComplete, _onInterruption, [], 1000, true, false, ["isNotUnconscious"]] call CFUNC(addHoldAction);


[QGVAR(help), {
    [CLib_player, false] call FUNC(setUnconscious);
}] call CFUNC(addEventhandler);
