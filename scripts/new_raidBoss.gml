///new_raidBoss();
//instance_create a gremlin based on wave number.
var _repeat = 0;
var gremNumber = irandom(100); //The number used to generate the gremlin out of 100%

if gremNumber >= (100-waveScale(5,wave,1,100)) then _repeat = waveScale(1,10,1,5);


while true
{
    //Initialize gremlin lists.
    var bossGremlins;
    
    //Add boss gremlins to the list as the wave number increases.
    bossGremlins[0] = obj_bombKing;
    
    var array_size = array_length_1d(bossGremlins);
    
    if wave >= 10 && kingDied_1 == true && gremNumber >= (100-waveScale(10,5,0,60)) then bossGremlins[array_size] = obj_nilmerg;
    if wave >= 15 && gremNumber >= 90 then bossGremlins[array_size] = obj_sphereKing;
    
    
    var mobType = "NORMAL"; //Normal or Special boss.
    
    //Select gremlin
    switch mobType
    {
        //-------------Select a boss-----------------
        case "NORMAL": { var i = bossGremlins[irandom(array_length_1d(bossGremlins)-1)]; }
        break;
    }
    
    var g = instance_create(choose(RAIDBOUND_Lower-16,RAIDBOUND_Upper+16),room_height/2,i);
    
    //Spawning more than once boss.
    if _repeat == 0
    { 
        //Inform the mob of its new title
        g.raid_boss = true;
        return g;
        break;
    }
    else
    {
        _repeat -= 1;
    }
}
