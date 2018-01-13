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

GVAR(cachedBuildingTypes) = false call CFUNC(createNamespace);
DFUNC(getLadderActions) = {
    params ["_typeOfBuilding"];
    private _memPoints = GVAR(cachedBuildingTypes) getVariable [_typeOfBuilding, []];
    if !(_memPoints isEqualTo []) exitWith { _memPoints };
    private _ladders = getArray (configFile >> "CfgVehicles" >> _typeOfBuilding >> "ladders");
    private _top = [];
    private _bottom = [];
    {
        _x params ["_ladderBottomMemPoint", "_ladderTopMemPoint"];
        _top pushBack _ladderTopMemPoint;
        _bottom pushBack _ladderBottomMemPoint;
    } forEach _ladders;
    _memPoints = [_top, _bottom];
    GVAR(cachedBuildingTypes) setVariable [_typeOfBuilding, _memPoints];
    _memPoints
};

DFUNC(onLadder) = {
    ((getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState _this) >> "onLadder")) == 1)
};

DFUNC(ladderContion) = {
    params ["_target", "_player"];
    ((_target distance _player) < 2) && {!(_this call FUNC(onLadder))}
};

DFUNC(getOnLadder) = {
    params ["_building", "_player", "_index", "_point"];
    _player action [["LadderDown", "LadderUp"] select _point, _building, _index, _point];
};

DFUNC(LadderAction) = {
    scopeName QGVAR(LadderAction);
    private _building = cursorObject;
    if !(_building isKindOf "House") then {
        _building = (getPos CLib_Player) nearestObject "House";
    };
    if !(_building isKindOf "House") exitWith {[]};

    private _ladderActions = _building getVariable [QGVAR(ladderData), []];
    if (_ladderActions isEqualTo []) then {
        _ladderActions = (typeOf _building) call FUNC(getLadderActions);
        _building setVariable [QGVAR(ladderData), _ladderActions];
    };
    if (_ladderActions isEqualTo []) exitWith {[]};
    _ladderActions params ["_top", "_bottom"];
    {
        private _type = _forEachIndex;
        {
            private _pos = _building modelToWorld (_building selectionPosition _x);
            DUMP("Ladder " + _x + " Pos" + str _pos);
            if (CLib_Player distance _pos < 2 && [CLib_Player, _pos, 1] call CFUNC(inFOV)) then {
                [_building, CLib_Player, _forEachIndex, _type] breakOut QGVAR(LadderAction);
            };
        } forEach _x;
    } forEach [_bottom ,_top];
    []
};

["cursorObjectChanged", {
    (_this select 0) params ["_building"];
    if !(_building isKindOf "House") exitWith {};
    if !(_building getVariable [QGVAR(ladderData), []] isEqualTo []) exitWith {};
    _building setVariable [QGVAR(ladderData), (typeOf _building) call FUNC(getLadderActions)];
}] call CFUNC(addEventhandler);
