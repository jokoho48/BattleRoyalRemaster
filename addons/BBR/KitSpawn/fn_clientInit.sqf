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
GVAR(clientObjectAdd) = [];
GVAR(clientObjectRemoved) = [];

["addNearBuilding", {
    (_this select 0) params ["_building"];
    GVAR(clientObjectAdd) pushBackUnique _building;
}] call CFUNC(addEventhandler);

["removeNearBuilding", {
    (_this select 0) params ["_building"];
    GVAR(clientObjectRemoved) pushBackUnique _building;
}] call CFUNC(addEventhandler);

[{
    if ((GVAR(clientObjectRemoved) isEqualTo []) && (GVAR(clientObjectAdd) isEqualTo [])) exitWith {};
    [QGVAR(buildingNearPlayerChanged), [GVAR(clientObjectAdd), GVAR(clientObjectRemoved)]] call CFUNC(serverEvent);
    GVAR(clientObjectAdd) = [];
    GVAR(clientObjectRemoved) = [];
}, 0] call CFUNC(addPerFrameHandler);
