///new_raidGremlin(x,y,gremNumber,flyChance,specialWaveID);
//instance_create a gremlin based on wave number.
var gremNumber = argument2; //The number used to generate the gremlin out of 100%
var specialChance = argument3; //The chance out of 100% that the mob will be flying;
var specialRaidID = argument4; //Whether or not to spawn gremlins under special parameters, and which parameters those are.

//Initialize gremlin lists.
var normalGremlins;
var specialGremlins;

normalGremlins[0] = obj_gremlin;
specialGremlins[0] = obj_shadowGremlin;

var normal_array_size = array_length_1d(normalGremlins);
var special_array_size = array_length_1d(specialGremlins);

//Locals
var build_target = waveScale(1,5,2,4); //Gremlin variety
var build_index = 0;


//Add normal gremlins to the list as the wave number increases.
switch specialRaidID
{
    case "SR_Shadow":
    {
        specialChance = 1;
        specialGremlins[0] = obj_shadowGremlin;
    }
    break;
    
    default:
    {    
        //Build'a wave!
        while build_index < build_target
        {    
            normal_array_size = array_length_1d(normalGremlins);
            special_array_size = array_length_1d(specialGremlins);
        
        
            //Add Gremlins to the list as the wave number increases.
            switch irandom(3)
            {
                case 0: if wave >= 4 { normalGremlins[normal_array_size] = obj_drillin; } break;
                case 1: if wave >= 2 { normalGremlins[normal_array_size] = obj_shadowGremlin; } break;
                case 2: if kingDied_1 == true { specialGremlins[special_array_size] = obj_grassGremlin; print("This");} break;
            }

            build_index += 1;
        }
    }
}
//Select type of mob to spawn: normal or special

//- Reroll chance based on whether or not a flying unit is in the roster.
if specialGremlins[0] == noone then specialChance = 0;

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

instance_create(argument0,argument1,i);
