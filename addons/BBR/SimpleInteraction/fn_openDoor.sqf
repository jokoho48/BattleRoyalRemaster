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
params ["_selection"];
private _target = cursorObject;
if ([_target, _selection] call FUNC(doorIsOpen)) then {
    {
        _target animateSource[[_selection, _x] call FUNC(getDoorSource) , 0];
        DUMP("Open Door");
        nil
    } count ["nosound", "normal"];
} else {
    if ([_target, _selection] call FUNC(doorIsLocked)) then {
        private _doorLockedSource = [_selection, "locked"] call FUNC(getDoorSource);
        _target animateSource[_doorLockedSource , (1 - (_target animationSourcePhase _doorLockedSource))];
        DUMP("Door Locked");
    } else {
        {
            _target animateSource[[_selection, _x] call FUNC(getDoorSource) , 1];
            DUMP("Close Door");
            nil
        } count ["nosound", "normal"];
    };
};
