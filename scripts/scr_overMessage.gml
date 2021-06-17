///scr_overMessage(string,font,duration,Color);
if !instance_exists(camera) then exit;

var font;
if argument1 == 0 then font = global.fnt_menu else font = argument1;
var time = argument2;
var col = argument3;

var i = instance_create(0,0,efct_overMessage);
i.font = font;
i.str = argument0;
i.time = time;
i.alarm[0] = time*room_speed; //Time displayed in seconds.
i.color = col;
i.direction = irandom_range(80,100);
i.friction = random_range(0.2,0.7);
