///distance_to_nearest_object(object);
//Wraps an instance_exists check, instance_nearest check, and distance_to function.
//returns noone if no instance.
var obj = argument0;

if (instance_exists(obj))
{
    var _int = instance_nearest(x,y,obj);
    return distance_to_point(_int.x,_int.y);
}
else return noone;
