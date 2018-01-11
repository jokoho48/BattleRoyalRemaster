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
DFUNC(compressKitArray) = {
    private _names = [];
    private _return = [];
    {
        private _index = _names find _x;
        private _amount = 1;
        if (_index == -1) then {
            _index = _names pushBack _x;
        } else {
            _amount = ((_return select _index) select 1) + 1;
        };
        _return set [_index, [_x, _amount]];
    } forEach _this;

    _return;
};
