#include "macros.hpp"
/*
    BBR

    Author: joko // Jonas & BadGuy

    Description:
    Description

    Parameter(s):
    None

    Returns:
    None
*/
["playAreaChanged", {
    params ["_pos", "_size", "_scaleTime"];

}] call CFUNC(addEventhandler);

[{

}, 0] call CFUNC(addPerFrameHandler);
