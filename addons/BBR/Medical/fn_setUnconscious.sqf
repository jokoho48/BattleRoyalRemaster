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
params ["_unit", "_state"];

["unconsciousnessChanged", _state] call CFUNC(localEvent);

if (_state) then {
    if (units _unit isEqualTo [_unit]) exitWith {
        ["playerKilled", [_unit, GVAR(lastDamageSource)]] call CFUNC(serverEvent);
    };
    _unit setUnconscious true;
    [{
        _this setUnconscious false;
    }, 2, _unit] call CFUNC(wait);
    _unit setAnimSpeedCoef 0.7;
    _unit setVariable [QGVAR(isUnconscious), true, true];
} else {
    _unit setAnimSpeedCoef 1;
    _unit setVariable [QGVAR(isUnconscious), false, true];
};
