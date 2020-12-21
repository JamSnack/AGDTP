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
    //green Pickaxe
    case 5: { tool_firerate = 30; tool_spr = spr_pickaxeGreen; pick_Dam = 1; pick_range = 2; pick_level = 0; } break;
    //Stinger drill
    case ITEMID.pickaxe_stingerDrill: { toolAnimation = "SHOOT"; tool_firerate = 15; tool_spr = spr_stingerDrill; pick_Dam = 1; pick_range = 2; pick_level = 1; } break;
}

//Apply tags
if hudControl.selectedSlot != noone
{
    var tagsUnloaded = hudControl.inventorySlotTags[hudControl.selectedSlot];
    
    if ds_exists(tagsUnloaded,ds_type_list)
    {
        for (i=0;i<ds_list_size(tagsUnloaded);i++)
        {
            var tag = tagsUnloaded[| i]
            
            //Tool Speed+
            if tag == "Tool Speed+" 
            { 
                tool_firerate = clamp(tool_firerate-(tool_firerate*0.20),1,100);
            }
        }
    }
}



obj_player.toolFireRate = tool_firerate;
obj_player.toolSprite = tool_spr;
obj_player.pickDamage = pick_Dam;
obj_player.pickRange = pick_range;
obj_player.pickLevel = pick_level;
obj_player.toolAnimation = toolAnimation;
obj_player.tool_snd = tool_snd;
