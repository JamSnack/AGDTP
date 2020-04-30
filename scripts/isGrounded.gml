///isGrounded(x,y);
var xx = argument0;
var yy = argument1;

if position_meeting(xx-16,yy,FLATLAND) || position_meeting(xx+16,yy,FLATLAND)
|| position_meeting(xx,yy-16,FLATLAND) || position_meeting(xx,yy+16,FLATLAND)
|| position_meeting(xx,yy+16,TILE) || position_meeting(xx+16,yy,TILE)
|| position_meeting(xx,yy-16,TILE) || position_meeting(xx-16,yy,TILE)
{ return true; } else return false;
