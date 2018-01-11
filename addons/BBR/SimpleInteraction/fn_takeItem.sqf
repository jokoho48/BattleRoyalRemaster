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
params ["_item", "_type"];
switch (toLower _type) do {
    case ("weapon"): {
        CLib_Player action ["TakeWeapon", cursorObject, _item];
    };
    case ("magazine"): {
        CLib_Player action ["TakeMagazine", cursorObject, _item];
    };
    case ("item"): {
        [{
            scopeName "_fnc_addItemMutex";
            params ["_item", "_target"];
            private _items = itemCargo _target;
            _items deleteAt (_items find _item);
            clearItemCargoGlobal _target;
            {
                _target addItemCargoGlobal [_x, 1];
                nil
            } count _items;
            if (getNumber(configFile >> "CfgWeapons" >> _item >> "itemInfo" >> "type") in [101, 201, 301, 302]) then {
                {
                    if (_item in (_x call BIS_fnc_compatibleItems)) then {
                        CLib_Player addWeaponItem [_x, _item];
                        breakTo "_fnc_addItemMutex";
                    };
                    nil
                } count [primaryWeapon CLib_Player, secondaryWeapon CLib_Player, handGunWeapon CLib_Player];
            } else {
                CLib_Player addItem _item;
            };

        }, [_item, cursorObject], "takeItem"] call CFUNC(mutex);
    };
    case ("bag"): {
        Clib_Player action ["TakeBag", cursorObject, _item];
    };
    case ("rearm"): {
        CLib_Player action ["rearm", cursorObject];
    };
};
