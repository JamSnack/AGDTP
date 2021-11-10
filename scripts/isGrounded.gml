///isGrounded(x,y);
var xx = argument0;
var yy = argument1;

if collision_point(xx-16,yy,FLATLAND,false,true) || collision_point(xx+16,yy,FLATLAND,false,true)
|| collision_point(xx,yy-16,FLATLAND,false,true) || collision_point(xx,yy+16,FLATLAND,false,true)
|| collision_point(xx,yy+16,TILE,false,true) || collision_point(xx+16,yy,TILE,false,true)
|| collision_point(xx,yy-16,TILE,false,true) || collision_point(xx-16,yy,TILE,false,true)
{ return true; } else return false;
