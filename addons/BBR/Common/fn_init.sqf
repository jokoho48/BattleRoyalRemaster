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
GVAR(worldSize) = worldSize/2;
GVAR(worldCenter) = [GVAR(worldSize), GVAR(worldSize), 0];
GVAR(playerSpawnSize) = 30;

["entityCreated", {
    (_this select 0) params ["_obj"];
    {
        _x addCuratorEditableObjects [[_obj], true];
    } count allCurators;
}] call CFUNC(addEventhandler);

#ifdef ISDEV
    DFUNC(createDebugMarker) = {
        params ["_pos", ["_icon", "hd_dot"], "_color", "_dir", "_text"];
        private _mrk = createMarker [format[QGVAR(%1_%2_%3_%4), _pos, _icon, _color, _dir, _text], _pos];
        _mrk setMarkerType _icon;
        if !(isNil "_color") then {
            _mrk setMarkerColor _color;
        };
        if !(isNil "_dir") then {
            _mrk setMarkerDir (180 - _dir);
        };
        if !(isNil "_text")  then {
            _mrk setMarkerText _text;
        };
        _mrk
    };
    addMissionEventHandler ["MapSingleClick", {
        params ["", ["_pos", getPos player], ["_alt", true]];
        if (_alt) then {
            _pos set [2, 0];
            (vehicle CLib_Player) setPos _pos;
        };
    }];
#else
    DFUNC(createDebugMarker) = {};
#endif
