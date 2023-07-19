///scr_spawnWorldCreatures(spawner_type);
//This script handles the spawning of things like hive growths.
var spawnAmt = irandom_range(0, waveScale(1,5,0,2));
var spawner_type = argument0;
var yy = 384; //TODO: Replace this with a global constant

for (i=0;i<spawnAmt;i++)
{
    var xInterval_Original = floor(clamp(irandom(room_width), 16, room_width-16)/16)*16 + 16;
    var yInterval_Original = yy+(16*9); //The lowest possible place a tree may spawn. -9 is the lowest possible tile height.
    var yInterval = yInterval_Original;
    var xInterval = xInterval_Original;

    //Check and correct Y position.
    if (xInterval >= RAIDBOUND_Lower && xInterval <= RAIDBOUND_Upper) { xInterval = choose(irandom_range(32,RAIDBOUND_Lower),irandom_range(RAIDBOUND_Upper,room_width-32)); }
    
    //Only place spawners in activated chunks
    if (position_meeting(xInterval,yInterval,OBSTA))
    {
        //Place spawners using previously used xInterval variable.
        while position_meeting(xInterval,yInterval,OBSTA) { yInterval -= 16; }
            
        //(y+16) because the spawners spawn one tile above the ground
        instance_create(xInterval,yInterval,spawner_type);
        
        xInterval = xInterval_Original;
        yInterval = yInterval_Original;
    }
}
