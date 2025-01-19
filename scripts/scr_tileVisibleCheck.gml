///scr_tileVisibleCheck(x,y);
//Returns true if the instance is inside view or barely outside the view.
var _x = argument0;
var _y = argument1;
var boundary = 16*4;

if (_y > view_yview-boundary && _y < view_yview+view_hview+boundary) && (_x > view_xview-boundary && _x < view_xview+view_wview+boundary)
{
    return true;
} else return false;
