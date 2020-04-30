///new_raidGremlin(x,y,gremNumber,flyChance);
//instance_create a gremlin based on wave number.
var gremNumber = argument2; //The number used to generate the gremlin out of 100%
var flyChance = argument3; //The chance out of 100% that the mob will be flying;

//Initialize gremlin lists.
var landGremlins;
var flyGremlins;

//Add land gremlins to the list as the wave number increases.
landGremlins[0] = obj_gremlin;
flyGremlins[0] = noone;

if wave >= 4 { landGremlins[1] = obj_drillin; }

//Add flying gremlins to the list as the wave number increases.
if wave >= 2 { flyGremlins[0] = obj_shadowGremlin; }

//Select type of mob to spawn: land or flying

//- Reroll chance based on whether or not a flying unit is in the roster.
if flyGremlins[0] == noone then flyChance = 0;

var mobType;
if gremNumber <= flyChance then mobType = "FLY" else mobType = "LAND";

//Select gremlin
switch mobType
{
    //-------------Select a land mob-----------------
    case "LAND": { var i = landGremlins[irandom(array_length_1d(landGremlins)-1)]; }
    break;
    
    //-------------Select a flying mob---------------
    case "FLY": { var i = flyGremlins[irandom(array_length_1d(flyGremlins)-1)]; }
    break;
}

instance_create(argument0,argument1,i);
