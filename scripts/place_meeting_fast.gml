/// place_meeting_fast(x_offset, y_offset, obj)
var x_offset = argument0
var y_offset = argument1
var obj = argument2;

//This should be an optimized place_meeting function.
x_offset += sign(x_offset);

if collision_rectangle(bbox_left+x_offset,bbox_top+y_offset,bbox_right+x_offset,bbox_bottom+y_offset,obj,false,true) != noone
{
    return true;
} else return false;
