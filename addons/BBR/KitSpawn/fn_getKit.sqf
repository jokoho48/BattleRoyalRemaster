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
params ["_building", "_typeOf", "_pos"]; // TODO: add More Posible Filter Conditions
private _data = selectRandom GVAR(KitData);
_data params ["", "", "", "_spawnClasses", "_forbittenAreas", "_allowedAreas"];
private _isClass = true;
private _inArea = true;
private _notInArea = false;
if !(_spawnClasses isEqualTo []) then {
    _isClass = [_typeOf, _spawnClasses] call CFUNC(isKindOfArray);
};
if !(_forbittenAreas isEqualTo []) then {
    _inArea = [_pos, _allowedAreas] call MFUNC(ArrayinArea);
};
if !(_allowedAreas isEqualTo []) then {
    _notInArea = [_pos, _forbittenAreas] call MFUNC(ArrayinArea);
};
private _spawnAllowed = (_isClass && _inArea && !_notInArea);

DUMP("Class: " + str _isClass);
DUMP("inArea: " + str _inArea);
DUMP("notInArea: " + str _notInArea);
DUMP("Spawn: " + str _spawnAllowed);
if !(_spawnAllowed) exitWith {_this call FUNC(getKit);};
_data resize 3;
_data
