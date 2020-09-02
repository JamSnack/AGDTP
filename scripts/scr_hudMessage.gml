///scr_hudMessage(string,font,duration,item,color,amt);
var hudString = argument0;
var hudFont;
if argument1 == 0 then hudFont = global.fnt_menu else hudFont = argument1;
var time = argument2;
var item = argument3; //0 if no image displayed.
var amt = argument5;

//Update an existing message object.
for (i=0;i<instance_number(efct_hudMessage);i++)
{
    var m = instance_find(efct_hudMessage,i);
    
    //Update pre-existing hudmessage.
    if m.img == item
    {
        if m.amt == "" then break;
        
        m.alarm[0] = time*room_speed;
        m.amt += amt;
        exit;
    }
}

var i = instance_create(0,0,efct_hudMessage);
i.hudFont = hudFont;
i.alarm[0] = time*room_speed; //Time displayed in seconds.
i.img = item;
i.color = argument4;

if amt == 0 then amt = "" else hudString = hudString+" x";
i.hudString = hudString;
i.amt = amt;
