///scr_updateConnections(X,Y);
var i = noone;

var xx = argument0;
var yy = argument1;
var delay = 4;

//If below
if collision_point(xx,yy+16,PLRTILE,false,true) != noone
{ with instance_position(xx,yy+16,PLRTILE) alarm[2] = delay; }

else if collision_point(xx,yy+16,PLR_NOCOL,false,true) != noone
{ with instance_position(xx,yy+16,PLR_NOCOL) alarm[2] = delay; }

//If above
if collision_point(xx,yy-16,PLRTILE,false,true) != noone
{ with instance_position(xx,yy-16,PLRTILE) alarm[2] = delay; }

else if collision_point(xx,yy-16,PLR_NOCOL,false,true) != noone
{ with instance_position(xx,yy-16,PLR_NOCOL) alarm[2] = delay; }

//If right
if collision_point(xx+16,yy,PLRTILE,false,true) != noone
{ with instance_position(xx+16,yy,PLRTILE) alarm[2] = delay; }

else if collision_point(xx+16,yy,PLR_NOCOL,false,true) != noone
{ with instance_position(xx+16,yy,PLR_NOCOL) alarm[2] = delay; }

//If left
if collision_point(xx-16,yy,PLRTILE,false,true) != noone
{ with instance_position(xx-16,yy,PLRTILE) alarm[2] = delay; }

else if collision_point(xx-16,yy,PLR_NOCOL,false,true) != noone
{ with instance_position(xx-16,yy,PLR_NOCOL) alarm[2] = delay; }
