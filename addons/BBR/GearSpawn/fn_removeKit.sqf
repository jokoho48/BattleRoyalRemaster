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
params ["_building"];
_building setVariable [QGVAR(isSpawned), false];
private _holders = _building getVariable [QGVAR(Holders), []];
private _kits = [];
#ifdef ISDEV
    private _mrks = _building getVariable [QGVAR(debugMarker), []];
    {
        deleteMarker _x;
        nil
    } count _mrks;
#endif

{
    private _weapons = (weaponCargo _x) call FUNC(compressKitArray);
    private _magazines = (magazineCargo _x) call FUNC(compressKitArray);
    private _items = (itemCargo _x) call FUNC(compressKitArray);
    if !(_weapons isEqualTo [] && _magazines isEqualTo [] && _items isEqualTo []) then {
        _kits pushBack [_x getVariable QGVAR(posData), [_weapons, _magazines, _items]];
    };
    _x setPos [-1000, -1000, -1000];
    _x setVariable [QGVAR(isLocked), false];
    nil
} count _holders;
_building setVariable [QGVAR(KitData), _kits];
