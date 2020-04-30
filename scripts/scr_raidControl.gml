///scr_raidControl(presetSettings,spawnRate,spawnChance,maxGrem,raidBoss);
var presetSettings = argument0;
var spawnRate = argument1;
var spawnChance = argument2;
var maxGrem = argument3;
var raidBoss = argument4;
var bossID = noone;

//----------------PRESET SETTINGS-------------------
switch presetSettings
{
    case "INTERM":
    {
        //---------- Intermission settings ---------
        spawnRate = 0.5;
        spawnChance = 20;
        maxGrem = 7;
        maxRaidProgress = 0;
        interm = true;
        raidBoss = false;
        raidProgress = 0;
        
        //Save the game.
        if wave > 0
        {
            with gameControl event_user(0);
            scr_hudMessage("Game saved.",global.fnt_menu,5,0,c_green);
            
            scr_dropItem(10,wave,0,obj_player.x,obj_player.y);
            scr_dropItem(15,wave,0,obj_player.x,obj_player.y);
        }
        
        //Tutorial quest
        if currentTask == 5 { if wave >= 5 then currentTask = 6}
        
        if instance_exists(GREM_BLOCK) then with GREM_BLOCK instance_destroy();
        
        scr_hudMessage("Peace ensues.",0,5,0,c_yellow);
        
        audio_stop_all();
        audio_play_sound(snd_overworld_1,10,true);
    }
    break;
    case "RAID":
    {
        //---------- Normal Raid settings ---------
        spawnRate = 1;
        spawnChance = 70+(wave*5);
        maxGrem = 10+(wave*2);
        maxRaidProgress = 20+(wave*5);
        
        interm = false;
        
        raidBoss = true;
        bossID = new_raidBoss();
        
        scr_hudMessage("The Gremlins are attacking!",0,5,0,c_yellow);
        
        audio_stop_all();
        audio_play_sound(snd_wave_1,10,true);
    }
    break;
}

//If raid then spawn GREMBLOCKS
if interm == false
{
    var flatLandsY = (room_height/2)-(16*3);

    instance_create(RAIDBOUND_Lower,flatLandsY,GREM_BLOCK); //Left Adjacent
    instance_create(RAIDBOUND_Lower-16,flatLandsY,GREM_BLOCK); //Left Most
    
    instance_create(RAIDBOUND_Upper,flatLandsY,GREM_BLOCK); //Right Adjacent
    instance_create(RAIDBOUND_Upper+16,flatLandsY,GREM_BLOCK); //Right Most
    
    //Remove tiles that are in the way of gremlin spawn zone.
    for (i=0;i<4;i++) //A total of 4 tiles can be removed.
    {
        var c = floor(i/2);
        var raid_Lower = (RAIDBOUND_Lower-32)+(i*16)-(c*16*2);
        var raid_Upper = (RAIDBOUND_Upper)+(i*16)-(c*16*2);
        
        //Remove left tiles
        instance_create(raid_Lower+16,flatLandsY+(c*16)-32,ANTI_TILE);
        
        //Remove right tiles
        instance_create(raid_Upper,flatLandsY+(c*16)-32,ANTI_TILE);
    }
    
    wave += 1;
    scr_overMessage("Wave "+string(wave),0,6,c_white);
}

//Clamps
maxRaidProgress = clamp(maxRaidProgress,10,100);
spawnChance = clamp(spawnChance,0,100);
maxGrem = clamp(maxGrem,0,25);

print(spawnChance);
worldControl.spawnRate = spawnRate;
worldControl.spawnChance = spawnChance;
worldControl.maxGrem = maxGrem;
worldControl.raidBoss = raidBoss;
worldControl.raidBossID = bossID;
