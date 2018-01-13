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
        GVAR(cachedBuildingTypes) getVariable [_typeOfBuilding, _memPoints];
        _memPoints
};

DFUNC(ladderContion) = {
    params ["_target", "_player"];
    ((_target distance _player) < 2) && {((getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState _player) >> "onLadder")) == 0)}
};

DFUNC(getUpLadder) = {
    params ["_building", "_player", "_index"];
    _player action ["LadderUp", _building, _index, 0];
};

DFUNC(getDownLadder) = {
    params ["_building", "_player", "_index"];
    _player action ["LadderDown", _building, _index, 1];
};

DFUNC(LadderAction) = {
    scopeName QGVAR(LadderAction);
    private _sPos = positionCameraToWorld [0,0,0];
    private _building = cursorObject;
    if !(_building isKindOf "House") then {
        _building = _sPos nearestObject "House";
    };

    private _ladderActions = _building getVariable [QGVAR(ladderData), []];
    if (_ladderActions isEqualTo []) then {
        _ladderActions = (typeOf _building) call FUNC(getLadderActions);
        _building setVariable [QGVAR(ladderData), _ladderActions];
    };
    if !(_ladderActions isEqualTo []) exitWith {[]};
    _ladderActions params ["_top", "_bottom"];
    {
        private _type = _forEachIndex;
        {
            if (_sPos distance (_building modelToWorld (_building selectionPosition _x)) < 1) then {
                [[_building, CLib_Player, _forEachIndex], [FUNC(getUpLadder), FUNC(getDownLadder)] select _type] breakOut QGVAR(LadderAction);
            };
        } forEach _x;
    } forEach [_top, _bottom];
    []
};

["onCursorObjectChanged", {
    (_this select 0) params ["_building"];
    if !(_building isKindOf "House") exitWith {};
    if !(_building getVariable [QGVAR(ladderData), []] isEqualTo []) exitWith {};
    _building setVariable [QGVAR(ladderData), (typeOf _building) call FUNC(getLadderActions)];
}] call CFUNC(addEventhandler);
