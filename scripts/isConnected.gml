///isConnected(x,y);
var xx = argument0;
var yy = argument1;

if collision_point(xx-16,yy,OBSTA,false,true) || collision_point(xx+16,yy,OBSTA,false,true)
|| collision_point(xx,yy-16,OBSTA,false,true) || collision_point(xx,yy+16,OBSTA,false,true)
|| collision_point(xx-16,yy,PLR_NOCOL,false,true) || collision_point(xx+16,yy,PLR_NOCOL,false,true)
|| collision_point(xx,yy-16,PLR_NOCOL,false,true) || collision_point(xx,yy+16,PLR_NOCOL,false,true)
{ return true; } else return false;
