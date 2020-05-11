///scr_roomTransition(type,text,font,color,imgSpeed,room);
if !instance_exists(efct_roomTransition)
{
    var i = instance_create(0,0,efct_roomTransition);
    var type = argument0;
    i.sprite_index = roomTransition_1;
    i.str = argument1;
    i.font = argument2;
    i.color = argument3;
    i.image_speed = argument4;
    i.rm_goto = argument5;
    i.room_current = room;
    i.speed_current = i.image_speed;
}
