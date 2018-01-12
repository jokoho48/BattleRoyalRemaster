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

["unconsciousnessChanged", _this] call CFUNC(localEvent);


if (_state) then {
    if (units _unit isEqualTo [_unit]) exitWith {
        ["playerKilled", [_unit, _instigator]] call CFUNC(serverEvent);
    };
    _unit setUnconscious true;
    [{
        _this setUnconscious false;
    }, 2, _unit] call CFUNC(wait);
    _unit setAnimSpeedCoef 0.7;
    _unit setVariable [QGVAR(isUnconscious), true, true]);
    private _currentWeapon = currentWeapon _unit;
    if (_currentWeapon == "") then { _currentWeapon = " "; };
    private _anim = ""
    switch (_currentWeapon) do {
        case (primaryWeapon _unit): {
            _anim = "amovppnemstpsraswrfldnon";
        };
        case (secondaryWeapon _unit): {
            _anim = "AmovPpneMstpSrasWlnrDnon";
        };
        case (handGunWeapon _unit): {
            _anim = "amovppnemstpsraswpstdnon";
        };
        case (binocular _unit): {
            _anim = "AmovPpneMstpSoptWbinDnon";
        };
    };
    [_unit, _anim, 3] call CFUNC(doAnimation);
} else {
    _unit setAnimSpeedCoef 1;
    _unit setVariable [QGVAR(isUnconscious), false, true]);
};
