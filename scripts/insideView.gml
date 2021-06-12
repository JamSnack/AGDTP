///insideView(x,y);
//Returns true if the instance is inside the view.
var xx = argument0+(sprite_width/2)*sign((camera.x)-x);
var yy = argument1+(sprite_height/2)*sign((camera.y)-y);

if (yy > view_yview && yy < view_yview+view_hview) && (xx > view_xview && xx < view_xview+view_wview)
{
    return true;
} else return false;
