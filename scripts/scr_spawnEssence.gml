///scr_spawnEssence(amt,time,instance#);
repeat(argument2)
{
    var i = instance_create(x,y,obj_essenceDrop);
    
    i.amt = argument0;
    with i alarm[0] = argument1;
}
