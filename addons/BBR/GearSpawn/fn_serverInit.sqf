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
GVAR(weaponHolderData) = [];
GVAR(KitData) = [];

{
    GVAR(KitData) pushBack [
        (getArray (_x >> "weapons")) call FUNC(compressKitArray),
        (getArray (_x >> "magazine")) call FUNC(compressKitArray),
        (getArray (_x >> "items")) call FUNC(compressKitArray),
        getArray (_x >> "spawnClasses"),
        getArray (_x >> "ForbittenSpawnAreas"),
        getArray (_x >> "SpawnAreas")
    ];
    nil
} count configProperties [missionConfigFile >> "BBR" >> "CfgGearSpawn" >> "Kits", "isClass _x", true];

DFUNC(getKit) = {
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
};

DFUNC(genereateKits) = {
    params ["_building"];
    private _usableBuildingPos = (_building buildingPos -1) select {!(_building isEqualTo [0,0,0])};
    private _kits = [];
    for "_i" from 0 to floor (random ((count _usableBuildingPos) / 2)) do {
        private _pos = selectRandom _usableBuildingPos;
        _usableBuildingPos deleteAt (_usableBuildingPos find _pos);
        private _kit = [_building, typeOf _building, _pos] call FUNC(getKit);
        _pos = AGLToASL _pos;
        private _up = [0, 0, 1];
        private _lis = lineIntersectsSurfaces [_pos, _pos vectorAdd [0,0,-10]];

        if !(_lis isEqualTo []) then {
            _pos = (_lis select 0) select 0;
        };
        _kits pushBack [[_pos vectorAdd [0, 0 , 0.01], _up], _kit];
    };
    _building setVariable [QGVAR(KitData), _kits];
    _kits
};

GVAR(removedBuildings) = [];
GVAR(addedBuildings) = [];

[QGVAR(buildingNearPlayerChanged), {
    (_this select 0) params ["_new", "_old"];
    GVAR(removedBuildings) append _old;
    GVAR(addedBuildings) append _new;
}] call CFUNC(addEventhandler);

[{
    if ((GVAR(removedBuildings) isEqualTo []) && (GVAR(addedBuildings) isEqualTo [])) exitWith {};
    DUMP("Start Find Buildings");
    GVAR(removedBuildings) = GVAR(removedBuildings) arrayInterSect GVAR(removedBuildings);
    GVAR(addedBuildings) = GVAR(addedBuildings) arrayInterSect GVAR(addedBuildings);

    private _overwritten = GVAR(addedBuildings) arrayInterSect GVAR(removedBuildings);

    GVAR(removedBuildings) = GVAR(removedBuildings) - _overwritten;
    GVAR(addedBuildings) = GVAR(addedBuildings) - _overwritten;

    if ((GVAR(removedBuildings) isEqualTo []) && (GVAR(addedBuildings) isEqualTo [])) exitWith {};
    DUMP("Buildings Found");
    {
        _x call FUNC(removeKit);
        nil
    } count GVAR(removedBuildings);

    {
        _x call FUNC(createKit);
        nil
    } count GVAR(addedBuildings);
    GVAR(addedBuildings) = [];
    GVAR(removedBuildings) = [];
}, 1] call CFUNC(addPerFrameHandler);
