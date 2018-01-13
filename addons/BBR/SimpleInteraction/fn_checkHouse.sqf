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
private _target = cursorObject;
if (isNull _target) exitWith {""};
private _sPos = positionCameraToWorld [0, 0, 0];
private _ePos = ([positionCameraToWorld [0, 0, 5], positionCameraToWorld [0, 0, 1.5]] select (cameraView == "Internal"));

private _ints = [];
{
    _ints = [_target, _x] intersect [_sPos, _ePos];
    if !(_ints isEqualTo []) then {
        breakTo SCRIPTSCOPENAME;
    };
    nil
} count ["VIEW", "GEOM", "FIRE"];
if (_ints isEqualTo []) exitWith {""};
(_ints select 0) params ["_selection", "_distance"];
private _endChar = _selection select [count _selection -1];
if (_endChar in ["a", "b", "d", "e", "f", "g"]) then {
    _selection = _selection select [0, count _selection -1];
};
if ("door" find _selection != -1 && "shut" find _selection != -1 && "lid" find _selection != -1) exitWith {[false, ""]};
private _intersectPos = AGLToASL positionCameraToWorld [0, 0, _distance - 0.1];
private _lis = lineIntersectsSurfaces [AGLToASL _sPos, _intersectPos, CLib_Player];
(_lis select 0) params [["_pos", _intersectPos]];
if (_pos distance _intersectPos > 0.1) exitWith {""};
_selection
