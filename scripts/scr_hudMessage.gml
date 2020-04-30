///scr_hudMessage(string,font,duration,item,color);
var hudString = argument0;
var hudFont;
if argument1 == 0 then hudFont = global.fnt_menu else hudFont = argument1;
var time = argument2;
var item = argument3; //0 if no image displayed.


var i = instance_create(0,0,efct_hudMessage);
i.hudFont = hudFont;
i.hudString = hudString;
i.alarm[0] = time*room_speed; //Time displayed in seconds.
i.img = item;
i.color = argument4;
