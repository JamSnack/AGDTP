///scr_getAchievementInfo(ACHIEVEMENT.name);
//Returns an array of information on an achievement.
var _d = array_create(2);
var _ach = argument0;
//[0] = name; [1] = description; [2] = reward;
_d[2] = "";

switch _ach
{
    case ACHIEVEMENT.getting_dirty: { _d[0] = "Getting Dirty"; _d[1] = "Collect a dirt clump."; _d[2] = "Turret Capacity +1"; } break;
    case ACHIEVEMENT.first_blood: { _d[0] = "First Blood"; _d[1] = "Kill something."; } break;
    case ACHIEVEMENT.sharpened_blade: { _d[0] = "Sharp Sticks"; _d[1] = "Craft a weapon."; } break;
    case ACHIEVEMENT.prepared_to_delve: { _d[0] = "Ready to Dig!"; _d[1] = "Craft a pickaxe."; } break;
    case ACHIEVEMENT.starter_base: { _d[0] = "Starter Base"; _d[1] = "Place a few tiles around the pie."; } break;
    case ACHIEVEMENT.geared_up: { _d[0] = "Geared Up"; _d[1] = "Equip an accessory."; } break;
    case ACHIEVEMENT.rusty_tools: { _d[0] = "Rusty Tools"; _d[1] = "Collect Copper Ore."; _d[2] = "Copper Ore Recipes Unlocked";} break;
    case ACHIEVEMENT.beached: { _d[0] = "Beached"; _d[1] = "Collect Seashell Metal Ore."; _d[2] = "Seashell-Metal Recipes Unlocked";} break;
    case ACHIEVEMENT.impenetrable: { _d[0] = "Impenetrable!"; _d[1] = "Place 500 tiles around the pie."; } break;
    //case ACHIEVEMENT.stalwart_creation: { _d[0] = "Stalwart Creation"; _d[1] = "Place 50,000 tiles around the pie."; } break;
    case ACHIEVEMENT.new_world: { _d[0] = "New World"; _d[1] = "Region shift."; } break;
    //case ACHIEVEMENT.avant_garde: { _d[0] = "Avant Garde"; _d[1] = "Use the workshop to tag a tool."; } break;
    case ACHIEVEMENT.explosive_gremlin: { _d[0] = "The Bomb"; _d[1] = "Kill the Bomb King."; } break;
    case ACHIEVEMENT.triple_king: { _d[0] = "Triple King"; _d[1] = "Kill the Sphere King."; } break;
    case ACHIEVEMENT.the_king_of_lesser_things: { _d[0] = "King Slayer 1"; _d[1] = "Kill Nilmerg, King of the Grasslands."; _d[2] = "Turret Capacity +1#Sweet Comb Recipes Unlocked";} break;
    case ACHIEVEMENT.the_king_of_sky_and_sea: { _d[0] = "King Slayer 2"; _d[1] = "Kill Bliplo, King of the Coral Coves."; _d[2] = "Turret Capacity +1";} break;
    case ACHIEVEMENT.fruity: { _d[0] = "Fruit Feller"; _d[1] = "Kill the Melon Bloom."; _d[2] = "Turret Capacity +1";} break;
    //case ACHIEVEMENT.speedrunner_2: { _d[0] = "Speed Runner 2"; _d[1] = "Kill Bliplo by wave 3."; _d[2] = "Turret Capacity +1";} break;
    case ACHIEVEMENT.handyman: { _d[0] = "Hands On"; _d[1] = "Crafted 250 items."; } break;
    case ACHIEVEMENT.digging_novice: { _d[0] = "Digging Novice"; _d[1] = "Mined 100 tiles."; } break;
    case ACHIEVEMENT.expert_on_rocks: { _d[0] = "Rock Expert"; _d[1] = "Mined 1,000 tiles."; } break;
    case ACHIEVEMENT.gremlin_slayer: { _d[0] = "Gremlin Slayer"; _d[1] = "Killed 500 enemies."; } break;
    case ACHIEVEMENT.the_king_of_everything: { _d[0] = "The King of Everything"; _d[1] = "Unlock every achievement."; } break;

    default:
    {
        _d[0] = "Error";
        _d[1] = "Achievement #"+string(_ach)+" not found.";
    }
}

return _d;
