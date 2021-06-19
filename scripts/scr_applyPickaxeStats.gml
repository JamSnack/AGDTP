///scr_applyPickaxeStats(pickaxe);
//Update the player variables to accomodate the equipped weapon.
var tool_firerate,tool_spr,pick_Dam,pick_range,pick_level,toolAnimation,tool_snd;

toolAnimation = "SWING";
pick_range = 2;
tool_snd = "SWISH";

//Apply animation and other variables
var item_id = argument0;

switch item_id
{
    case 4: { tool_spr = spr_pickaxe; } break;
    case 5: { tool_spr = spr_pickaxeGreen; } break;
    case ITEMID.pickaxe_stingerDrill: { toolAnimation = "SHOOT"; tool_spr = spr_stingerDrill; } break;
}

//Apply stats
scr_getToolStats(item_id);

obj_player.toolFireRate = toolFireRate;
obj_player.toolSprite = tool_spr;
obj_player.pickDamage = pick_damage;
obj_player.pickRange = pick_range;
obj_player.pickLevel = pickLevel;
obj_player.toolAnimation = toolAnimation;
obj_player.tool_snd = tool_snd;
