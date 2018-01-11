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
params ["_weapon"];
private _retValue = "NO_WEAPON";
switch (true) do {
    case (_weapon isKindOf ["Rifle", configFile >> "CfgWeapons"]): { _retValue = "PRIMARY"; };
    case (_weapon isKindOf ["Launcher", configFile >> "CfgWeapons"]): { _retValue = "HANDGUN"; };
    case (_weapon isKindOf ["Pistol", configFile >> "CfgWeapons"]): { _retValue = "SECONDARY"; };
};
_retValue
