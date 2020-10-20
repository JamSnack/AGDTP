///scr_applyPickaxeStats(pickaxe);
//Update the player variables to accomodate the equipped weapon.
var tool_firerate,tool_spr,pick_Dam,pick_range,pick_level,toolAnimation,tool_snd;
var swish = choose(snd_swish1,snd_swish4);

toolAnimation = "SWING";
tool_snd = noone; //swish;

switch argument0
{
    //Dull Pickaxe
    case 4: { tool_firerate = 40; tool_spr = spr_pickaxe; pick_Dam = 1; pick_range = 2; pick_level = 0; } break;
    //Dull Pickaxe
    case 5: { tool_firerate = 30; tool_spr = spr_pickaxeGreen; pick_Dam = 1; pick_range = 2; pick_level = 0; } break;
}

obj_player.toolFireRate = tool_firerate;
obj_player.toolSprite = tool_spr;
obj_player.pickDamage = pick_Dam;
obj_player.pickRange = pick_range;
obj_player.pickLevel = pick_level;
obj_player.toolAnimation = toolAnimation;
obj_player.tool_snd = tool_snd;

pickaxeIcon = tool_spr;
