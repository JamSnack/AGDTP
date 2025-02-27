///new_raidGremlin(x,y,gremNumber,flyChance,specialWaveID);
//instance_create a gremlin based on wave number.
var gremNumber = argument2; //The number used to generate the gremlin out of 100%
var specialChance = argument3; //The chance out of 100% that the mob will be flying;
var specialRaidID = argument4; //Whether or not to spawn gremlins under special parameters, and which parameters those are.

//Select type of mob to spawn: normal or special

//- Reroll chance based on whether or not a special unit is in the roster.
if array_length_1d(specialGremlins) == 1 then specialChance = 0;

var mobType;
if gremNumber <= specialChance then mobType = "SPECIAL" else mobType = "NORMAL";

//Select gremlin
switch mobType
{
    //-------------Select a mob-----------------
    case "NORMAL": { var i = normalGremlins[irandom(normal_array_size-1)]; }
    break;
    
    //-------------Select a special mob---------------
    case "SPECIAL": { var i = specialGremlins[irandom(special_array_size-1)]; }
    break;
}

if i != noone
{
    instance_create(argument0,argument1,i);
}
