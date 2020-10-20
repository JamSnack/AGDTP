///scr_raidControl(presetSettings,spawnRate,spawnChance,maxGrem,raidBoss);
var presetSettings = argument0;
var spawnRate = argument1;
var spawnChance = argument2;
var maxGrem = argument3;
var raidBoss = argument4;

var bossID = noone;
var specialRaid = false;
var special_raidID = noone;

var musicTransitionTime = 1000; //2.5 seconds, 2500 milliseconds

//Spawn Rate is: alarm[0] = room_speed/spawn_rate;
//Spawn Chance is: if irandom(100) < spawnChance;

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
        worldControl.world_Time = 0;
        
        //Give wave rewards and Save the game.
        if wave > 0
        {
            //Rewards
            scr_dropItem(10,wave,0,obj_player.x,obj_player.y,noone);
            scr_dropItem(15,wave,0,obj_player.x,obj_player.y,noone);
        
        
            with gameControl event_user(0);
            //scr_hudMessage("Game saved.",global.fnt_menu,5,0,c_green,0);
        }
        
        //Tutorial quest
        if currentTask == 5 { if wave >= 5 then currentTask = 6}
        
        if instance_exists(GREM_BLOCK) then with GREM_BLOCK instance_destroy();
        
        scr_hudMessage("Peace ensues.",0,5,0,c_yellow,0);
        
        scr_musicTransition(snd_overworld_1,musicTransitionTime);
        
        nextRaid = "RAID";
    }
    break;
    case "RAID":
    {
        //---------- Normal Raid settings ---------
        // - 5% Chance to turn into a special raid.
        //#region Special Raids
        if irandom(100) <= 20
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
                    
                    scr_hudMessage("Special Raid incoming!",0,20,0,c_yellow,0);
                    scr_overMessage("!!The Shadow Gremlins are swarming!!",global.fnt_menu,5,c_yellow,0,-35);
                    
                    scr_musicTransition(snd_wave_1,musicTransitionTime);
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
            bossID = new_raidBoss();
        }
        
        scr_hudMessage("The Gremlins are attacking!",0,5,0,c_yellow,0);
        
        scr_musicTransition(snd_wave_1,musicTransitionTime);
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
        bossID = instance_create(choose(RAIDBOUND_Lower-16,RAIDBOUND_Upper+16),room_height/2,obj_sphereKing);;
        
        scr_hudMessage("The Sphere King has arrived.",0,20,0,c_yellow,0);
        
        scr_musicTransition(snd_Triple_King,musicTransitionTime);
    }
    break;
}

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
worldControl.specialRaid = specialRaid;
worldControl.special_raidID = special_raidID;
