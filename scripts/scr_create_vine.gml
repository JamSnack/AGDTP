///scr_create_vine( x, y, target_x, target_y, return_bool, damage_amt, vine_speed, instance_to_grab );
//Creates a vine at the given point.

var _vine = instance_create(argument0,argument1,obj_vine);
_vine.parent_id = id;
_vine.vine_x = x;
_vine.vine_y = y;
_vine.vine_target_x = argument2;
_vine.vine_target_y = argument3;
_vine.behavior_return = argument4; //Whether or not to return to origin point and die.
_vine.damage_amt = argument5;
_vine.vine_speed = argument6;
_vine.instance_to_grab = argument7;

return _vine;
