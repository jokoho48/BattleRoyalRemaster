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
params [["_target", cursorObject]];
if !(_target isKindOf "WeaponHolder" || _target isKindOf "WeaponHolderSimulated") exitWith {[]};

// check for backpacks
{
    if (backpack CLib_Player == "") then {
        [_x, "bag"] breakOut SCRIPTSCOPENAME;
    };
    nil
} count (backpackCargo cursorObject);

// check for Weapons
{
    switch (true) do {
        case (primaryWeapon CLib_Player == "" && {_x call MFUNC(getWeaponType) == "PRIMARY"}): {
            [_x, "weapon"] breakOut SCRIPTSCOPENAME;
        };
        case (secondaryWeapon CLib_Player == "" && {_x call MFUNC(getWeaponType) == "SECONDARY"}): {
            [_x, "weapon"] breakOut SCRIPTSCOPENAME;
        };
        case (handGunWeapon CLib_Player == "" && {_x call MFUNC(getWeaponType) == "HANDGUN"}): {
            [_x, "weapon"] breakOut SCRIPTSCOPENAME;
        };
    };
    nil
} count (weaponCargo _target);

// check for Items
{
    [_x, "magazine"] breakOut SCRIPTSCOPENAME;
    nil
} count (magazineCargo cursorObject);

if !((itemCargo _target) isEqualTo []) exitWith {
    [itemCargo _target, "item"];
};

["REARM", "rearm"];
