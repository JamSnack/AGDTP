///scr_updateConnections(X,Y);
var i = noone;

var xx = argument0;
var yy = argument1;
var delay = 4;

//If below
if position_meeting(xx,yy+16,PLRTILE)
{ with instance_position(xx,yy+16,PLRTILE) alarm[2] = delay; }

if position_meeting(xx,yy+16,PLR_NOCOL)
{ with instance_position(xx,yy+16,PLR_NOCOL) alarm[2] = delay; }

//If above
if position_meeting(xx,yy-16,PLRTILE)
{ with instance_position(xx,yy-16,PLRTILE) alarm[2] = delay; }

if position_meeting(xx,yy-16,PLR_NOCOL)
{ with instance_position(xx,yy-16,PLR_NOCOL) alarm[2] = delay; }

//If right
if position_meeting(xx+16,yy,PLRTILE) 
{ with instance_position(xx+16,yy,PLRTILE) alarm[2] = delay; }

if position_meeting(xx+16,yy,PLR_NOCOL)
{ with instance_position(xx+16,yy,PLR_NOCOL) alarm[2] = delay; }

//If left
if position_meeting(xx-16,yy,PLRTILE) 
{ with instance_position(xx-16,yy,PLRTILE) alarm[2] = delay; }

if position_meeting(xx-16,yy,PLR_NOCOL)
{ with instance_position(xx-16,yy,PLR_NOCOL) alarm[2] = delay; }
