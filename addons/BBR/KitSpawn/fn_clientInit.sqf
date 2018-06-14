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

addMissionEventHandler ["Draw3D", {
    {
        drawIcon3D ["a3\ui_f_curator\data\cfgcurator\entity_selected_ca.paa", [1,1,1,1], _x modelToWorld [0,0,0], 1, 1, 0, ""];
        nil
    } count GVAR(weaponHolderData);
}];
