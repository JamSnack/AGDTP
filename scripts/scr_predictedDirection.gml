///scr_predictedDirection(x,y,target_x,target_y,target_speed);
//This script is used to predict the trajectory a turret needs to fire at in order to hit a moving target.

var initial_x = argument0;
var initial_y = argument1;
var target_x = argument2;
var target_y = argument3;
var target_hspeed = argument4;
var target_vspeed = argument5;

return point_direction(initial_x,initial_y,target_x+target_hspeed,target_y+target_vspeed);
