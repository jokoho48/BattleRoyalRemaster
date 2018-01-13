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
            private _notAddedItems = [];

            private _fnc_addItem = {
                params ["_item"];
                if (CLib_Player canAdd _item) then {
                    CLib_Player addItem _item;
                } else {
                    _notAddedItems pushback _item;
                };
            };

            {
                private _item = _x;
                if (getNumber(configFile >> "CfgWeapons" >> _item >> "itemInfo" >> "type") in [101, 201, 301, 302]) then {
                    {
                        scopeName "_fnc_addItemLoop";
                        if (toLower (_item) in ((_x call BIS_fnc_compatibleItems) apply {toLower _x})) then {
                            switch (_forEachIndex) do {
                                case (0): {
                                    if (((primaryWeaponItems CLib_Player) select (_item call MFUNC(attachmentType)) == "")) then {
                                        Clib_Player addPrimaryWeaponItem _item;
                                    } else {
                                        _item call _fnc_addItem;
                                    };
                                    breakOut "_fnc_addItemLoop";
                                };
                                case (1): {
                                    if (((secondaryWeaponItems CLib_Player) select (_item call MFUNC(attachmentType)) == "")) then {
                                        Clib_Player addSecondaryWeaponItem _item;
                                    } else {
                                        _item call _fnc_addItem;
                                    };
                                    breakOut "_fnc_addItemLoop";
                                };
                                case (2): {
                                    if (((handgunItems CLib_Player) select (_item call MFUNC(attachmentType)) == "")) then {
                                        Clib_Player addHandgunItem _item;
                                    } else {
                                        _item call _fnc_addItem;
                                    };
                                    breakOut "_fnc_addItemLoop";
                                };
                                default {
                                    _item call _fnc_addItem;
                                    breakOut "_fnc_addItemLoop";
                                };
                            };
                        } else {
                            if (_forEachIndex == 3) then {
                                _item call _fnc_addItem;
                            };
                        };
                        nil
                    } forEach [primaryWeapon CLib_Player, secondaryWeapon CLib_Player, handGunWeapon CLib_Player, ""];
                } else {
                    _item call _fnc_addItem;
                };
                nil
            } count _items;
            CLib_Player playAction "putdown";
            private _wh = createVehicle ["WeaponHolderSimulated_Scripted", [0,0,0], [], 0, "CAN_COLLIDE"];
            {
                _wh addItemCargoGlobal [_x, 1];
            } count _notAddedItems;
        }, [_item, cursorObject], "takeItem"] call CFUNC(mutex);
    };
    case ("bag"): {
        Clib_Player action ["TakeBag", cursorObject, _item];
    };
    case ("rearm"): {
        CLib_Player action ["rearm", cursorObject];
    };
};
