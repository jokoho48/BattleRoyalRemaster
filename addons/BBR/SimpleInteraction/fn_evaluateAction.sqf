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

if (GVAR(lastUpdate) > diag_frameNo) exitWith {GVAR(LastEvaluatedAction)};
GVAR(lastUpdate) = diag_frameNo + 15;
GVAR(actionText) = "";
private _onLadder = CLib_Player call FUNC(onLadder);
DUMP("OnLadder Check " + str _onLadder);
if (_onLadder) exitWith {
    GVAR(actionText) = "Jump Of Lader";
    GVAR(LastEvaluatedAction) = ["ladderoff"];
    GVAR(LastEvaluatedAction);
};

private _weaponHolder = cursorObject call FUNC(checkWeaponHolder);
DUMP("WeaponHolder Check " + str _weaponHolder);
if !(_weaponHolder isEqualTo []) exitWith {
    //GVAR(actionText) = format ["Take Item %1", getText (configFile >> "CfgWeapons" >> (_weaponHolder select 0) >> "displayName")];
    GVAR(actionText) = "Take Item";
    GVAR(LastEvaluatedAction) = ["weaponholder", _weaponHolder];
    GVAR(LastEvaluatedAction);
};

private _houseCheck = call FUNC(checkHouse);
DUMP("House Check " + str _houseCheck);
if !(_houseCheck isEqualTo "") exitWith {
    if ([cursorObject, _houseCheck] call FUNC(doorIsOpen)) then {
        GVAR(actionText) = "Close Door";
    } else {
        GVAR(actionText) = "Open Door";
    };

    GVAR(LastEvaluatedAction) = ["door", _houseCheck];
    GVAR(LastEvaluatedAction);
};

private _ladderAction = call FUNC(LadderAction);
DUMP("Ladder Check " + str _ladderAction);
if !(_ladderAction isEqualTo []) exitWith {
    GVAR(actionText) = "Get On Ladder";
    GVAR(LastEvaluatedAction) = ["ladder", _ladderAction];
    GVAR(LastEvaluatedAction);
};

GVAR(LastEvaluatedAction) = [];
GVAR(LastEvaluatedAction);
