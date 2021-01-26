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

//Spawn Rate is: alarm[0] = room_speed/spawn_rate;
//Spawn Chance is: if irandom(100) < spawnChance;


//------FORCED WAVES----------------
if interm == true
{
    if wave+1 >= 10 && kingDied_1 == false && region == "GRASSLANDS" then presetSettings = "KING";
}

//----------------PRESET SETTINGS-------------------
switch presetSettings
{
    case "INTERM":
    {
        //---------- Intermission settings ---------
        spawnRate = 0.5;
        spawnChance = 20+clamp(floor(wave/2),0,40);
        maxGrem = 7;
        maxRaidProgress = 0;
        interm = true;
        raidBoss = false;
        raidProgress = 0;
        
        //- return to daylight.
        worldControl.dayTransition = true;
        world_Time = 0;
        
        //Save the game.
        with gameControl event_user(0);
        
        
        if instance_exists(GREM_BLOCK) then with GREM_BLOCK instance_destroy();
        scr_hudMessage("Peace ensues.",0,5,0,c_yellow,0);
        scr_musicTransition(snd_The_Grasslands,musicTransitionTime);
        nextRaid = "RAID";
        
        //Tutorial Quest
        if currentTask == 3 { currentTask = 4; obj_tutorialControl.alarm[1] = room_speed*5; }
        
        //REGION SHIFT
        if worldControl.region_shift == true
        {
            if scr_getInvenItemAmt(ITEMID.item_gremEssence) < 50
            {
                scr_hudMessage("50 essence is required#to shift regions!",global.fnt_Ui,5,0,c_red,0);
            }
            else
            {
                //- reset the player
                obj_player.alarm[1] = 1; //RESPAWN THE PLAYER
                
                //- shift the region
                instance_create(x,y,region_shifter);
                
                //- hud message
                scr_hudMessage("The region is shifing...",global.fnt_Ui,5,0,c_aqua,0);
            }
        }
    }
    break;
    
    case "RAID":
    {
        //---------- Normal Raid settings ---------
        // - 5% Chance to turn into a special raid.
        //#region Special Raids
        if irandom(100) <= 10 && wave > 2
        {
            //Special raids
            special_raidID = choose("SR_Shadow");
                
            switch special_raidID
            {
                case "SR_Shadow":
                {
                    //---------- Special Raid: Shadow Gremlins Only settings ---------
                    specialRaid = true;
                    spawnRate = 1+(0.1*wave);
                    spawnChance = 70+(wave*5);
                    maxGrem = 10+(wave*2);
                    maxRaidProgress = 15+(wave*3);
                    
                    interm = false;
                    
                    if wave >= 6
                    {
                        raidBoss = true;
                        bossID = new_raidBoss(obj_shadowGremlin);
                    }
                    
                    scr_hudMessage("Special Raid incoming!",0,20,0,c_yellow,0);
                    scr_overMessage("!!The Shadow Gremlins are swarming!!",global.fnt_menu,5,c_yellow,0,-35);
                }
                break;
            }
            break;
        }
        //#endregion
        
        spawnRate = 1;
        spawnChance = 70+(wave*5);
        maxGrem = 10+(wave*2);
        maxRaidProgress = 20+(wave*5);
        
        interm = false;
        
        if random(1) < wave/10 && wave > 2
        {
            raidBoss = true;
            bossID = new_raidBoss(0);
        }
        
        scr_hudMessage("The Gremlins are attacking!",0,5,0,c_yellow,0);
    }
    break;
    
    case "SPHERE":
    {
        //---------- Sphere King Raid ---------
        specialRaid = true;
        spawnRate = 1+(0.1*wave);
        spawnChance = 70+(wave*5);
        maxGrem = 10+(wave*2);
        maxRaidProgress = 15+(wave*3);
        
        interm = false;
        
        raidBoss = true;
        bossID = new_raidBoss(obj_sphereKing);
        
        scr_hudMessage("The Sphere King has arrived.",0,20,0,c_yellow,0);
    }
    break;
    
    case "KING":
    {
        //ONLY THE GRASSLANDS REGION EXISTS RIGHT NOW.
        //Get the region > spawn appropriate region king...
        
        //---------- Region King Raid ---------
        specialRaid = true;
        spawnRate = 1+(0.1*wave);
        spawnChance = 70+(wave*5);
        maxGrem = 10+(wave*2);
        maxRaidProgress = 15+(wave*3);
        
        interm = false;
        
        raidBoss = true;
        bossID = new_raidBoss(obj_nilmerg);
        
        if kingDied_1 == false then scr_hudMessage("Nilmerg will destroy you!",0,20,0,c_yellow,0);
    }
    break;
}

//MUSIC CONTROL
var _music = snd_The_Grasslands;

if interm == false then _music = snd_wave_1;

if instance_exists(bossID)
{
    var _boss = bossID.object_index;
    
    switch _boss
    {
        case obj_sphereKing: { _music = snd_Triple_King; } break;
        case obj_nilmerg: { _music = snd_FlightoftheRegionKing; } break;
    }
}

scr_musicTransition(_music,musicTransitionTime);


//GREMBLOCK CONTROL
//#region
if interm == false
{
    var flatLandsY = (room_height/2)-(16*3);

    instance_create(RAIDBOUND_Lower-8,flatLandsY,GREM_BLOCK); //Left Adjacent
    instance_create(RAIDBOUND_Lower-24,flatLandsY,GREM_BLOCK); //Left Most
    
    instance_create(RAIDBOUND_Upper+8,flatLandsY,GREM_BLOCK); //Right Adjacent
    instance_create(RAIDBOUND_Upper+24,flatLandsY,GREM_BLOCK); //Right Most
    
    //Remove tiles that are in the way of gremlin spawn zone.
    for (i=0;i<4;i++) //A total of 4 tiles can be removed.
    {
        var c = floor(i/2);
        var raid_Lower = (RAIDBOUND_Lower-32)+(i*16)-(c*16*2);
        var raid_Upper = (RAIDBOUND_Upper)+(i*16)-(c*16*2);
        
        //Remove left tiles
        instance_create(raid_Lower+8,flatLandsY+(c*16)-32,ANTI_TILE);
        
        //Remove right tiles
        instance_create(raid_Upper+8,flatLandsY+(c*16)-32,ANTI_TILE);
    }
    
    wave += 1;
    scr_overMessage("Wave "+string(wave),0,6,c_white,0,0);
}
//#endregion

//Clamps
maxRaidProgress = clamp(maxRaidProgress,10,100);
spawnChance = clamp(spawnChance,0,100);
maxGrem = clamp(maxGrem,0,25);
spawnRate = clamp(spawnRate,0,6);

worldControl.spawnRate = spawnRate;
worldControl.spawnChance = spawnChance;
worldControl.maxGrem = maxGrem;
worldControl.raidBoss = raidBoss;
worldControl.raidBossID = bossID;
worldControl.special_raidID = special_raidID;

//Buff that lead boss boy
with bossID event_perform(ev_create,0);
