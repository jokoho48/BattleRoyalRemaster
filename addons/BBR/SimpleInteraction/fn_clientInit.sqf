#include "macros.hpp"
#include "\a3\editor_f\Data\Scripts\dikCodes.h"
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

["missionStarted", {
    params ["_display"];
    _display displayAddEventHandler ["KeyDown", {
        scopeName "_fnc_keyDown";
        params ["", "_dik", "", "", ""];
        private _ret = false;
        if (_dik == DIK_F) then {
            private _weaponHolder = cursorObject call FUNC(checkWeaponHolder);
            if !(_weaponHolder isEqualTo []) exitWith {
                _weaponHolder call FUNC(takeItem);
                _ret = true;
            };
            private _houseCheck = call FUNC(checkHouse);
            if (_houseCheck select 0) exitWith {
                _ret = true;
                (_houseCheck select 1) call FUNC(openDoor);
            };
        };
        _ret;
    }];
}] call CFUNC(addEventhandler);


DFUNC(doorIsLocked) = {
    params ["_target", "_selection"];
    (_target getVariable[(format["bis_disabled_Door_%1", (_selection select[(count _selection) - 1, 1])]), 0] == 1);
};
DFUNC(doorIsOpen) = {
    params ["_target", "_selection"];
    (_target animationSourcePhase ([_selection] call FUNC(getDoorSource))) >= 0.5
};

DFUNC(getDoorSource) = {
    params ["_selection", "_source"];

    switch (toLower _source) do {
        case ("nosound"): {
            format["%1_noSound_source", _selection];
        };
        case ("locked"): {
            format["%1_locked_source", _selection];
        };
        default {
            format["%1_sound_source", _selection];
        };
    }
}