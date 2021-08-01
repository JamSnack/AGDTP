///scr_tileVisibleCheck(x,y);
//Returns true if the instance is inside view or barely outside the view.
var xx = argument0+(sprite_width/2)*sign((camera.x)-x);
var yy = argument1+(sprite_height/2)*sign((camera.y)-y);
var boundary = 16*3;

if (yy > view_yview-boundary && yy < view_yview+view_hview+boundary) && (xx > view_xview-boundary && xx < view_xview+view_wview+boundary)
{
    return true;
} else return false;
