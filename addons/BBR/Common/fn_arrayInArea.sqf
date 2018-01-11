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
params ["_pos", "_areas"];
{
    if (_pos inArea _x) then {
        true breakOut SCRIPTSCOPENAME;
    };
    nil
} count _areas;
false
