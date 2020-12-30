///twitch_execute_command(name,data);
//name = the chatter's username.
//date = the message.
var name = argument0;
var data = argument1;

var cd = room_speed*3; //Basic cooldown timer

//Help command priority
if string_pos("!help",data) == 1
{
    twitch_chat_say("!help, !discord, !spawnRateUp, !spawnRateDown, !halfTime, !fling, !boom, !lightning, !rtp, !rspawn"+" @"+string(name));
}


//other checks
else if !instance_exists(worldControl) || twitch_cooldown == true 
{
    if twitch_cooldown == true then twitch_chat_say("Cooldown: "+string(round(alarm_get(0)/60)));
    exit;
}

//Room checks
if room != rm_zero
{
    if room == rm_lobby
    {
        twitch_chat_say("Not in the flatlands, @"+string(name)+" !");
        exit;
    }
}

//Command parsing
if string_pos("!discord",data) == 1
{
    //Reply with a link to the discord server.
    twitch_chat_say("@"+string(name)+" https://discord.gg/NQCWq64");
}
else if string_pos("!spawnRateUp",data) == 1
{
    //Increases the spawn rate.
    var spwn = worldControl.spawnRate;
    spwn = min(10,spwn+1);
    
    worldControl.spawnRate = spwn;
    twitch_chat_say("Spawn Rate: "+string(60/spwn));
    scr_hudMessage("Spawn Rate increased!",global.fnt_Ui,5,0,c_blue,0);
    
}
else if string_pos("!spawnRateDown",data) == 1
{
    //Decreases the spawn rate.
    var spwn = worldControl.spawnRate;
    spwn = max(1,spwn-1);
    
    worldControl.spawnRate = spwn;
    twitch_chat_say("Spawn Rate: "+string(60/spwn));
    scr_hudMessage("Spawn Rate decreased!",global.fnt_Ui,5,0,c_blue,0);
}
else if string_pos("!halfTime",data) == 1
{
    var world_TimeMax = worldControl.world_TimeMax;
    world_Time = approach(world_Time,world_TimeMax,0.5);
    twitch_chat_say("World time: "+string(world_Time));
    scr_hudMessage("Intermissioned halfed!",global.fnt_Ui,5,0,c_blue,0);
    
    cd = room_speed*10;
}
else if string_pos("!fling",data) == 1
{
    var h = irandom_range(6,18);
    obj_player.hForce = choose(-1,1)*h;
    obj_player.vForce = -irandom_range(12,20);
    
    twitch_chat_say("Flung!");
    scr_hudMessage("Flung!",global.fnt_Ui,5,0,c_blue,0);
    
    cd = room_speed*h;
}
else if string_pos("!boom",data) == 1
{
    var xx = obj_player.x;
    var yy = obj_player.y;

    var _exp = instance_create(xx,yy,obj_explosion);
    _exp.type = TILE;
    _exp.radius = 6*16;
    _exp.damage = 5;
    
    var _exp = instance_create(xx,yy,obj_explosion);
    _exp.type = PLRTILE;
    _exp.radius = 6*16;
    _exp.damage = 5;
    
    var _exp = instance_create(xx,yy,obj_explosion);
    _exp.type = ENEMY;
    _exp.radius = 6*16;
    _exp.damage = 5;
    
    twitch_chat_say("Kerblooey!");
    
    cd = room_speed*10;
} 
else if string_pos("!rtp",data) == 1
{
    var xx = irandom_range(16,room_width-16);
    var yy = irandom_range(16,room_height-16);
    
    while place_meeting(xx,yy,OBSTA) yy -= 16;
    
    obj_player.x = xx;
    obj_player.y = yy;
    
    twitch_chat_say("Teleported to: ("+string(xx)+","+string(yy)+")");
    
    cd = room_speed*30;
}
else if string_pos("!lightning",data) == 1
{
    obj_player.hsp_walk = 16;
    twitch_chat_say("Faster than a speeding bullet!");
    
    cd = room_speed*5;
    scr_hudMessage("Lightning",global.fnt_Ui,5,0,c_blue,0);
}
else if string_pos("!rspawn",data) == 1
{
    var i = instance_create(x,y,choose(obj_shadowGremlin,obj_grassGremlin,obj_gremlin,obj_drillin,obj_beeMinion,obj_sphereMinion,obj_spherePylon));
    twitch_chat_say("Enemy spawned: "+string(object_get_name(i.object_index)));
    
    scr_hudMessage("Enemy spawned",global.fnt_Ui,5,0,c_blue,0);
    cd = room_speed*5;
}


//Bot cooldown
alarm[0] = cd;
twitch_cooldown = true;
