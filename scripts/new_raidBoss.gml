/// new_raidBoss(desired_boss)
///new_raidBoss(desired_boss);
//desired_boss: leave as '0' if no boss is desired. This will overwrite the boss generation.
var desired_boss = argument0;

//instance_create a gremlin based on wave number.
var _repeat = 0;
var gremNumber = irandom(100); //The number used to generate the gremlin out of 100%
var difficulty = scr_getDifficulty();

if gremNumber >= (100-waveScale(5,wave,1,100)) then _repeat = waveScale(1,10,0,5);

//Disable multi-bosses on special raids.
if specialRaid == true then _repeat = 0;


while true
{
    //Initialize gremlin lists.
    var bossGremlins;
    
    //Add boss gremlins to the list as the wave number increases.
    bossGremlins[0] = obj_bombKing;
    
    var array_size = array_length_1d(bossGremlins);
    
    if difficulty >= 15 && gremNumber >= 70 then bossGremlins[array_size] = obj_sphereKing;
    if region == "COVE" && difficulty >= 8 then bossGremlins[array_size] = obj_crabKing;
    
    
    var mobType = "NORMAL"; //Normal or Special boss.
    
    //Select gremlin
    switch mobType
    {
        //-------------Select a boss-----------------
        case "NORMAL": { var i = bossGremlins[irandom(array_length_1d(bossGremlins)-1)]; }
        break;
    }
    
    if desired_boss == 0
    { var g = instance_create(choose(RAIDBOUND_Lower-16,RAIDBOUND_Upper+16),world_height,i); }
    else
    { var g = instance_create(choose(RAIDBOUND_Lower-16,RAIDBOUND_Upper+16),world_height,desired_boss); }
    
    //All boss mobs should not despawn.
    g.canDespawn = false;
    
    //Spawning more than once boss.
    if _repeat == 0
    { 
        //Inform the mob of its new title as leading boss
        g.raid_boss = true;
        
        //Reinitialize the gremlin, buffing it.
        worldControl.raidBossID = g;
        with g { event_perform(ev_create,0); }
        return g; //return the ID before checking for the ID :P
        
        break;
    }
    else
    {
        _repeat -= 1;
    }
}
