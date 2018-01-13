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
