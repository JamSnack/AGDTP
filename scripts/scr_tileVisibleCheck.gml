///scr_tileVisibleCheck(bbox_left,bbox_top,bbox_right,bbox_bottom);
//Returns true if the instance is inside view or barely outside the view.
var box_left = argument0;
var box_top = argument1;
var box_right = argument2;
var box_bottom = argument3;
var boundary = 16*4;

if (box_top > view_yview-boundary && box_bottom < view_yview+view_hview+boundary) && (box_right > view_xview-boundary && box_left < view_xview+view_wview+boundary)
{
    return true;
} else return false;
