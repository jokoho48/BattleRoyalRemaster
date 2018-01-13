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
params ["_pos", "_up"];
GVAR(weaponHolderData) = GVAR(weaponHolderData) - [objNull];

private _holder = objNull;
{
    if (alive _x && _x getVariable [QGVAR(isLocked), false]) then {
        _holder = _x;
        breakTo SCRIPTSCOPENAME;
    };
    if !(alive _x) then {
        deleteVehicle _x;
    };
} forEach GVAR(weaponHolderData);

if (isNull _holder) then {
    _holder = createVehicle ["WeaponHolderSimulated_Scripted", [0,0,0], [], 0, "CAN_COLLIDE"];
    _holder setPosASL _pos;
    GVAR(weaponHolderData) pushBackUnique _holder;
} else {
    clearItemCargoGlobal _holder;
    clearWeaponCargoGlobal _holder;
    clearMagazineCargoGlobal _holder;
    _holder setPosASL _pos;
};
_holder setVectorUp _up;
_holder getVariable [QGVAR(isLocked), false];
_holder
