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
            private _action = call FUNC(evaluateAction);
            if (_action isEqualTo []) exitWith {};
            _ret = true;
            switch (_action select 0) do {
                case ("weaponholder"): {
                    (_action select 1) call FUNC(takeItem);
                    GVAR(lastUpdate) = diag_frameNo;
                };
                case ("door"): {
                    (_action select 1) call FUNC(openDoor);
                    GVAR(lastUpdate) = diag_frameNo;
                };
                case ("ladder"): {
                    (_action select 1) call FUNC(getOnLadder);
                    GVAR(lastUpdate) = diag_frameNo ;
                };
                case ("ladderoff"): {
                    private _building = cursorObject;
                    if !(_building isKindOf "House") then {
                        _building = (getPos CLib_Player) nearestObject "House";
                    };
                    if (_building isKindOf "House") then {
                        CLib_Player action ["ladderOff", cursorObject];
                        GVAR(lastUpdate) = diag_frameNo;
                    };
                };
                default {
                    _ret = false;
                };
            };
        };
        _ret;
    }];
}] call CFUNC(addEventhandler);

DFUNC(doorIsLocked) = {
    params ["_target", "_selection"];
    (_target getVariable [(format["bis_disabled_Door_%1", (_selection select[(count _selection) - 1, 1])]), 0] == 1);
};
DFUNC(doorIsOpen) = {
    params ["_target", "_selection"];
    (_target animationSourcePhase ([_selection] call FUNC(getDoorSource))) != 0
};

DFUNC(getDoorSource) = {
    params ["_selection", ["_source", "normal"]];

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
    };
};
["cursorObjectChanged", {
    call FUNC(evaluateAction);
}] call CFUNC(addEventhandler);
[{
    call FUNC(evaluateAction);
}, 1.3] call CFUNC(addPerFrameHandler);
