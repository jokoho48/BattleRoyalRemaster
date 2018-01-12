#include "macros.hpp"
/*
    BBR

    Author: joko // Jonas & BadGuy

    Description:
    Description

    Parameter(s):
    None

    Returns:
    None
*/
params ["_unit", "_selectionName", "_damage", "_source", "_projectile", "_hitPartIndex", "_instigator"];
if !((local _unit) && (alive _unit)) exitWith {};
private _damageReceived = _damage;
if (_hitPartIndex >= 0) then {
    private _lastDamage = _unit getHit _selectionName;
    _damageReceived = (_damage - _lastDamage) max 0;
    [_damageReceived] call FUNC(bloodEffect);
    GVAR(Threshold) = GVAR(Threshold) + _damageReceived;
} else {
    _damageReceived = (_damage - damage _unit) max 0;
};

if (_hitPartIndex <= 7) then {
    if (_damage >= 1) then {
        if (!(_unit getVariable [QGVAR(isUnconscious), false])) then {
            ["playerKilled", [_unit, _instigator]] call CFUNC(serverEvent);
            [_unit, true] call FUNC(setUnconscious);
            _unit setVariable [QGVAR(bleedingRate), (_unit getVariable [QGVAR(bleedingRate), 0]) + _damage];
        };
    };
};

_damage min 0.95;
