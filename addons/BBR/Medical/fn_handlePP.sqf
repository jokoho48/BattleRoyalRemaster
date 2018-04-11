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
if (GVAR(Threshold) >= BORDER) then {
    if (alive CLib_player) then {
        if !(GVAR(PPRunning)) then {
            GVAR(PPRunning) = true;
        };
        private _workValue = (GVAR(Threshold) - BORDER) / (MAXSUPP - BORDER);
        GVAR(Threshold) = GVAR(Threshold) - (_workValue * 10);
        addCamShake
        [
            (_workValue * 1),        // Power
            2 + (_workValue * 23),    // Frequency
            1.5                        // Duration
        ];

        GVAR(blur) ppEffectAdjust [(_workValue * 1.28)];
        GVAR(blur) ppEffectCommit 0.5;

        GVAR(cc) ppEffectAdjust [1, 1, 0, [0,0,0,0], [1,1,1,(1 - (_workValue * 0.40))],[1,1,1,0]];
        GVAR(cc) ppEffectCommit 0.5;

        GVAR(rBlur) ppEffectAdjust [(_workValue * 0.011), (_workValue * 0.011), 0.2, 0.2];
        GVAR(rBlur) ppEffectCommit 0.05;
    };
} else {
    if (GVAR(PPRunning)) then {
        GVAR(PPRunning) = false;
        GVAR(cc) ppEffectAdjust [1, 1, 0, [0,0,0,0], [1,1,1,1],[1,1,1,0]];
        GVAR(cc) ppEffectCommit 0.5;
        GVAR(Threshold) = 0;
        // Blur
        GVAR(blur) ppEffectAdjust [0];
        GVAR(blur) ppEffectCommit 0.5;

        // RBlur
        GVAR(rBlur) ppEffectAdjust [0, 0, 0, 0];
        GVAR(rBlur) ppEffectCommit 1;
    };
};
