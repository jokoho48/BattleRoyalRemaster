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
            params ["_items", "_target"];
            clearItemCargoGlobal _target;
            {
                private _item = _x;
                if (getNumber(configFile >> "CfgWeapons" >> _item >> "itemInfo" >> "type") in [101, 201, 301, 302]) then {
                    {
                        scopeName "_fnc_addItemLoop";
                        if (toLower (_item) in ((_x call BIS_fnc_compatibleItems) apply {toLower _x})) then {
                            switch (_forEachIndex) do {
                                case (0): {
                                    Clib_Player addPrimaryWeaponItem _item;
                                    breakOut "_fnc_addItemLoop";
                                };
                                case (1): {
                                    Clib_Player addSecondaryWeaponItem _item;
                                    breakOut "_fnc_addItemLoop";
                                };
                                case (2): {
                                    Clib_Player addHandGunItem _item;
                                    breakOut "_fnc_addItemLoop";
                                };
                                default {
                                    CLib_Player addItem _item;
                                    breakOut "_fnc_addItemLoop";
                                };
                            };
                        } else {
                            if (_forEachIndex == 3) then {
                                CLib_Player addItem _item;
                            };
                        };
                        nil
                    } forEach [primaryWeapon CLib_Player, secondaryWeapon CLib_Player, handGunWeapon CLib_Player, ""];
                } else {
                    CLib_Player addItem _item;
                };
                nil
            } count _items;
            player playAction "putdown";
        }, [_item, cursorObject], "takeItem"] call CFUNC(mutex);
    };
    case ("bag"): {
        Clib_Player action ["TakeBag", cursorObject, _item];
    };
    case ("rearm"): {
        CLib_Player action ["rearm", cursorObject];
    };
};
