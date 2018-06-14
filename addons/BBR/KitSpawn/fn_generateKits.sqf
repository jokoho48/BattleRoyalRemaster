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
private _usableBuildingPos = (_building buildingPos -1) select {!(_building isEqualTo [0,0,0])};
private _kits = [];
for "_i" from 0 to floor (random ((count _usableBuildingPos) / 2)) do {
    private _pos = selectRandom _usableBuildingPos;
    _pos set [2, (_pos select 2) + 0.1];
    _usableBuildingPos deleteAt (_usableBuildingPos find _pos);
    private _kit = [_building, typeOf _building, _pos] call FUNC(getKit);
    _pos = AGLToASL _pos;
    private _up = [0, 0, 1];
    private _lis = lineIntersectsSurfaces [_pos, _pos vectorAdd [0,0,-10], objNull, objNull, true, 1, "VIEW", "GEOM"];

    if !(_lis isEqualTo []) then {
        _pos = (_lis select 0) select 0;
    };
    _kits pushBack [[_pos vectorAdd [0, 0 , 0.01], _up], _kit];
};
_building setVariable [QGVAR(KitData), _kits];
_kits
