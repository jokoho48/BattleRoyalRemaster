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

GVAR(lastDamageSource) = objNull;
["playerChanged", {
    (_this select 0) params ["_newPlayer", "_oldPlayer"];
    private _oldId = _oldPlayer getVariable [QGVAR(HandleDamageId), -1];
    if (_oldId != -1) then {
        _oldPlayer removeEventHandler ["HandleDamage", _oldId];
    };
    private _id = _newPlayer addEventHandler ["HandleDamage", {_this call FUNC(handleDamage)}];
    _newPlayer setVariable [QGVAR(HandleDamageId), _id];
}] call CFUNC(addEventhandler);

["Respawn", {
    (_this select 0) params ["_newUnit"];
    _newUnit setVariable [QGVAR(isUnconscious), false, true];
}] call CFUNC(addEventHandler);

// Force Player to stay Prone when "Uncon"
["AnimStateChanged", {
    (_this select 0) params ["_unit", "_anim"];
    if !((isNull (objectParent _unit)) && (_unit getVariable [QGVAR(isUnconscious), false])) exitWith {};
    if ((stance _unit) in ["CROUCH", "STAND"]) then {
        private _currentWeapon = currentWeapon _unit;
        if (_currentWeapon == "") then { _currentWeapon = " "; };
        private _anim = "";
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
    };
}] call CFUNC(addEventhandler);

// Adding Actions
call FUNC(actionHeal);
call FUNC(actionHelp);

["isNotUnconscious", {
    !(_caller getVariable [QGVAR(isUnconscious), false])
}] call CFUNC(addCanInteractWith);
