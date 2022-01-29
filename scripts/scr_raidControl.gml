///scr_raidControl(presetSettings,spawnRate,spawnChance,maxGrem,raidBoss);
var presetSettings = argument0;
var spawnRate = argument1;
var spawnChance = argument2;
var maxGrem = argument3;
var raidBoss = argument4;

var bossID = noone;
specialRaid = false;
var special_raidID = noone;

var musicTransitionTime = 1000; //2.5 seconds, 2500 milliseconds

var difficulty = scr_getDifficulty();

//Spawn Rate is: alarm[0] = room_speed/spawn_rate;
//Spawn Chance is: if irandom(100) < spawnChance;


//------FORCED WAVES----------------
/*if interm == true
{
    if wave+1 >= 10 && kingDied_1 == false && region == "GRASSLANDS" then presetSettings = "KING_NILMERG";
}*/

//----------------PRESET SETTINGS-------------------
switch presetSettings
{
    case "INTERM":
    {
        //---------- Intermission settings ---------
        if wave != 0 then global.waves_survived += 1;
        
        spawnRate = 0.5;
        spawnChance = 20+clamp(floor(wave/2),0,40);
        maxGrem = 7;
        maxRaidProgress = 0;
        interm = true;
        raidBoss = false;
        raidProgress = 0;
        
        //- Return to intermission.
        with worldControl
        {
            dayTransition = true;
            world_Time = 0;
            world_TimeMax -= 10;
            
            if world_TimeMax < 300 then world_TimeMax = 300;
            
            //We need to construct a new wave
            event_user(1);
        }
        
        //Save the game.
        with gameControl event_user(0);
        
        
        if instance_exists(GREM_BLOCK) then with GREM_BLOCK instance_destroy();
        scr_hudMessage("Peace ensues.",0,5,0,c_yellow,0);
        //scr_musicTransition(snd_The_Grasslands,musicTransitionTime);
        nextRaid = "RAID";
        
        //Tips
        if kingDied_1 == true && tip_shifting == false
        {
            scr_createTip(1.5,1.75,"shifting");
        }
        
        //REGION SHIFT
        if worldControl.region_shift == true
        {
            var _cost = scr_getRegionCost(worldControl.shift_destination);
            
            if currency_essence < _cost
            {
                scr_hudMessage("Region shift failed.",global.fnt_Ui,5,0,c_red,0);
            }
            else
            {
                //- reset the player
                obj_player.alarm[1] = 1; //RESPAWN THE PLAYER
                
                //- shift the region
                instance_create(x,y,region_shifter);
                
                //- hud message
                scr_hudMessage("The region is shifing...",global.fnt_Ui,5,0,c_aqua,0);
                
                //- remove essence
                scr_removeEssence(_cost);
                
                //ACHIEVEMENT - New World
                scr_unlockAchievement(ACHIEVEMENT.new_world);
            }
        }
        
        //Spawn melon-bloom
        if (kingDied_2 == true && !instance_exists(INV_ENEMY) && irandom(1) == 0)
        {
            instance_create(irandom_range(64,room_width-64), room_height-64, obj_melonster);
            scr_hudMessage("A creature has crawled up from the depths!",global.fnt_Ui,5,0,c_green,0); 
        }
    }
    break;
    
    case "RAID":
    {
        //---------- Normal Raid settings ---------
        // - 5% Chance to turn into a special raid.
        //#region Special Raids
        if irandom(10) <= 1 && wave > 2
        {
            //Special raids
            special_raidID = choose("SR_Shadow");
                
            switch special_raidID
            {
                case "SR_Shadow":
                {
                    //---------- Special Raid: Shadow Gremlins Only settings ---------
                    specialRaid = true;
                    spawnRate = clamp(1+(0.1*wave),1,30); //spawn rate = 60/spawnRate. This caps the spawn rate to 60/30 or 2;
                    spawnChance = 70+(wave*5);
                    maxGrem = 15+(wave*2);
                    maxRaidProgress = min(25+(wave*3),100);
                    
                    interm = false;
                    
                    if wave >= 3
                    {
                        raidBoss = true;
                        bossID = new_raidBoss(obj_shadowGremlin);
                    }
                    
                    scr_hudMessage("Special Raid incoming!",0,20,0,c_yellow,0);
                }
                break;
            }
        }
        //#endregion
        else
        {
        
            spawnRate = 0.5+(difficulty*0.18); //spawn rate = 60/spawnRate. NOTE: difficulty*0.25 seemed too high. Decreased to 0.18 - 11/9/21
            spawnChance = 60+(difficulty*3);
            maxGrem = 8+(wave*1);
            maxRaidProgress = 5+((wave+1)*2);
            
            interm = false;
            
            if (random(1) < wave) && wave > 2
            {
                raidBoss = true;
                bossID = new_raidBoss(0);
            }
        }
        
        scr_hudMessage(choose("The Gremlins are attacking!","Here they come!","The Gremlins are invading!"),0,5,0,c_yellow,0);
    }
    break;
    
    case "SPHERE":
    {
        //---------- Sphere King Raid ---------
        specialRaid = true;
        spawnRate = 0.5+(difficulty*0.25);
        spawnChance = 60+(difficulty*3);
        maxGrem = 8+(wave*1);
        maxRaidProgress = 15+(wave*2);
        
        interm = false;
        
        raidBoss = true;
        bossID = new_raidBoss(obj_sphereKing);
        
        scr_hudMessage("The Sphere King has arrived.",0,20,0,c_yellow,0);
    }
    break;
    
    case "KING":
    {
        //Get the region > spawn appropriate region king...
        var region_boss = obj_nilmerg;
        var _text = "null";
        
        switch region
        {
            case "GRASSLANDS": { region_boss = obj_nilmerg; _text = "Nilmerg will destroy you!"; } break;
            case "COVE": { region_boss = obj_bliplo; _text = "Bliplo is angry!"; } break;
        }   
        
        //---------- Region King Raid ---------
        specialRaid = true;
        spawnRate = spawnRate = 0.5+(difficulty*0.25);
        spawnChance = 60+(difficulty*3);
        maxGrem = 8+(wave*1);
        maxRaidProgress = 20+(wave*5);
        
        interm = false;
        
        raidBoss = true;
        bossID = new_raidBoss(region_boss);
        
        scr_hudMessage(_text,0,20,0,c_yellow,0);
    }
    break;
}

//MUSIC CONTROL
var _music = snd_The_Grasslands;

if interm == false
{
    _music = snd_wave_1;
}
else
{
    switch region
    {
        case "GRASSLANDS": { _music = snd_The_Grasslands; } break;
        case "COVE": { _music = snd_Salty_Paradise; } break;
    }
}

if instance_exists(bossID)
{
    var _boss = bossID.object_index;
    
    switch _boss
    {
        case obj_bliplo: { _music = snd_Triple_King; } break;
        case obj_nilmerg: { _music = snd_FlightoftheRegionKing; } break;
    }
}

scr_musicTransition(_music,musicTransitionTime);


//GREMBLOCK CONTROL
//#region
if interm == false
{
    var flatLandsY = (384+48)-(16*3);

    instance_create(RAIDBOUND_Lower-8,flatLandsY,GREM_BLOCK); //Left Adjacent
    instance_create(RAIDBOUND_Lower-24,flatLandsY,GREM_BLOCK); //Left Most
    
    instance_create(RAIDBOUND_Upper+8,flatLandsY,GREM_BLOCK); //Right Adjacent
    instance_create(RAIDBOUND_Upper+24,flatLandsY,GREM_BLOCK); //Right Most
    
    //Remove tiles that are in the way of gremlin spawn zone.
    for (i=0;i<4;i++) //A total of 6 tiles can be removed.
    {
        var c = floor(i/2);
        var raid_Lower = (RAIDBOUND_Lower-32)+(i*16)-(c*16*2);
        var raid_Upper = (RAIDBOUND_Upper)+(i*16)-(c*16*2);
        
        //Remove left tiles
        var l_tile = instance_create(raid_Lower+8,flatLandsY+(c*16)-32,ANTI_TILE);
        
        //Remove right tiles
        var u_tile = instance_create(raid_Upper+8,flatLandsY+(c*16)-32,ANTI_TILE);
        
        //Update portal sprites
        if i == 0 
        {
            l_tile.visible = true;
            u_tile.visible = true;
        } 
    }
    
    wave += 1;
    scr_overMessage("Wave "+string(wave),0,6,c_white);
    
    //We need to construct a new wave
    worldControl.special_raidID = special_raidID;
    with worldControl event_user(1);
}
//#endregion

//Clamps
maxRaidProgress = clamp(maxRaidProgress,7,100);
spawnChance = clamp(spawnChance,0,90);
maxGrem = clamp(maxGrem,0,25);
spawnRate = clamp(spawnRate,0.5,10);

worldControl.spawnRate = spawnRate;
worldControl.spawnChance = spawnChance;
worldControl.maxGrem = maxGrem;
worldControl.raidBoss = raidBoss;

//Buff that lead boss boy
if instance_exists(bossID)
{
    if object_get_parent(bossID.object_index) == ENEMY
    {
        with bossID event_perform(ev_create,0);
    }
}
