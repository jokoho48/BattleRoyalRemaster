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

["playerChanged", {
    (_this select 0) params ["_new", "_old"];
    [QGVAR(updatePlayerIcons), units _new + units _old] call CFUNC(targetEvent);
}] call CFUNC(addEventhandler);

[QGVAR(updatePlayerIcons), {
    {

    } count GVAR(2dGroups);

    {
        [_x, _forEachIndex] call FUNC(addPlayerToTracker);
    } forEach (units CLib_Player);
}] call CFUNC(addEventhandler);

GVAR(2dGroups) = [];
GVAR(3dGroups) = [];

DFUNC(addPlayerToTracker) = {
    params ["_unit", "_index"];
    private _iconId = format ["%1_%2", name _unit, _index];
    private _color = [0.62, 0.7, 0.94, 1];
    if (CLib_player != _unit) then {
        _color = [
            [1, 0, 0.1, 1],
            [0.1, 1, 0, 1],
            [0.1, 0, 1, 1],
            [1, 1, 0.1, 1]
        ] select _index;
    };
    private _mapIcon = [(configFile >> "CfgVehicles" >> typeOf _unit >> "Icon"), DEFAULT_ICON, true] call CFUNC(getConfigDataCached);

    private _manIcon = ["ICON", _mapIcon, _color, _unit, 20, 20, _unit, "", 1, 0.08, "RobotoCondensed", "right", {
        if (_position getVariable ["ACE_isUnconscious", false]) then {
            _texture = "\A3\ui_f\data\igui\cfg\revive\overlayicons\u100_ca.paa";
            _color = [1, 0, 0, 1];
            _width = 30;
            _height = 30;
            _angle = 0;
        };
    }];

    private _manDescription = ["ICON", "a3\ui_f\data\Map\Markers\System\dummy_ca.paa", [1, 1, 1, 1], _unit, 22, 22, 0, name _unit, 2];

    [_iconId, [_manIcon]] call CFUNC(addMapGraphicsGroup);
    [_iconId, [_manIcon, _manDescription], "hover"] call CFUNC(addMapGraphicsGroup);

    if ((group _unit) isEqualTo (group player)) then {
        [_iconID + "line", _unit, player] call FUNC(addUnitLineToTracker);
    };
};
