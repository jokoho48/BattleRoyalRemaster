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

_building setVariable [QGVAR(isSpawned), true];

private _kits = _building getVariable QGVAR(KitData);
if (isNil "_kits") then {
    _kits =_building call FUNC(generateKits);
};
private _holders = [];

DEFMARKERSARRAY;

{
    _x params ["_posData", "_kit"];
    _posData params ["_pos", "_up"];
    _kit params ["_weapons", "_magazines", "_items"];

    if !(_weapons isEqualTo [] && _magazines isEqualTo [] && _items isEqualTo []) then {
        private _holder = [_pos, _up] call FUNC(getWeaponHolder);
        NOCLEAN(_holder);
        _holders pushback _holder;
        CREATEDEBUGMARKER;
        _holder setVariable [QGVAR(posData), _posData];
        {
            private _i = _x;
            if (_i isEqualType "") then {
                _i = [_i, 1];
            };
            _holder addWeaponCargoGlobal _i;
            nil
        } count _weapons;

        {
            private _i = _x;
            if (_i isEqualType "") then {
                _i = [_i, 1];
            };
            _holder addMagazineCargoGlobal _i;
            nil
        } count _magazines;

        {
            private _i = _x;
            if (_i isEqualType "") then {
                _i = [_i, 1];
            };
            _holder addItemCargoGlobal _i;
            nil
        } count _items;
    };
    nil
} count _kits;

_building setVariable [QGVAR(Holders), _holders];
#ifdef ISDEV
    _building setVariable [QGVAR(debugMarker), _mrks];
#endif
