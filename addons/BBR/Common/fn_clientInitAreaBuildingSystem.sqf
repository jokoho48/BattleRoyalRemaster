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
DFUNC(checkNearBuildings) = {
    if (GVAR(nextUpdate) > diag_frameNo) exitWith {};
    private _nearBuildings = nearestObjects [getPos CLib_Player, ["Building"], GVAR(playerSpawnSize)];
    _nearBuildings = _nearBuildings select {!([0,0,0] isEqualTo ((_x buildingPos -1) select 0))};
    if !(GVAR(currentNearBuildings) isEqualTo _nearBuildings) then {
        private _newBuildings = _nearBuildings - GVAR(currentNearBuildings);
        {
            ["addNearBuilding", _x] call CFUNC(localEvent);
            nil
        } count _newBuildings;
        private _oldBuildings = GVAR(currentNearBuildings) - _nearBuildings;
        {
            ["removeNearBuilding", _x] call CFUNC(localEvent);
            nil
        } count _oldBuildings;
        GVAR(currentNearBuildings) = _nearBuildings;

        GVAR(nextUpdate) = diag_frameNo + 25;
    } else {
        GVAR(nextUpdate) = diag_frameNo + 50;
    };
};

GVAR(currentNearBuildings) = [];
GVAR(nextUpdate) = diag_frameNo;

[{
    call FUNC(checkNearBuildings);
}, 1] call CFUNC(addPerFrameHandler);
["onCursorObjectChanged", {
    call FUNC(checkNearBuildings);
}] call CFUNC(addEventhandler);
["playerChanged", {
    call FUNC(checkNearBuildings);
}] call CFUNC(addEventhandler);
["vehicleChanged", {
    call FUNC(checkNearBuildings);
}] call CFUNC(addEventhandler);
