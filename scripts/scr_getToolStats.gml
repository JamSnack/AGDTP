///scr_getToolStats(item_id);
//Returns variables that define tool ability. Mainly used for descriptions.
var tool_firerate = 0;
var wep_Dam = 0;
var wep_Knock = 0;
var pick_Dam = 0;
var pick_level = 0;

switch argument0
{    
    //---- WEAPONS ----
    case ITEMID.weapon_greenSword: { tool_firerate = 30; tool_spr = spr_swordGreen; wep_Dam = 4; wep_Knock = 3.25; } break;
    case ITEMID.weapon_starter: { tool_firerate = 34; tool_spr = spr_sword; wep_Dam = 2; wep_Knock = 2.75; } break;
    case ITEMID.weapon_weakBow: { tool_firerate = 35; tool_spr = spr_weakBow; wep_Dam = 3; wep_Knock = 1; } break;
    case ITEMID.weapon_subLimeMachineGun: {tool_firerate = 12; tool_spr = spr_subLimeMachineGun; wep_Dam = 3; wep_Knock = 1.1; } break;
    case ITEMID.weapon_sphereLauncher: {tool_firerate = 55; tool_spr = spr_sphereLauncher; wep_Dam = 3; wep_Knock = 2; } break;
    case ITEMID.weapon_beemerang: { tool_firerate = 50; tool_spr = spr_nothing; wep_Dam = 4; wep_Knock = 3; } break;
    case ITEMID.weapon_acornRifle: { tool_firerate = 70; tool_spr = spr_acornRifle; wep_Dam = 7; wep_Knock = 4; } break;
    case ITEMID.weapon_waterGun: { tool_firerate = 20; tool_spr = spr_waterGun; wep_Dam = 6; wep_Knock = 2;} break;
    
    // ---- PICKAXES ----
    case 4: { tool_firerate = 40; pick_Dam = 1; pick_level = 0; } break;
    case 5: { tool_firerate = 35; pick_Dam = 1; pick_level = 0; } break;
    case ITEMID.pickaxe_stingerDrill: { tool_firerate = 25; pick_Dam = 1; pick_level = 1; } break;
}

if hudControl.selectedSlot != noone
{
    var tagsUnloaded = hudControl.inventorySlotTags[hudControl.selectedSlot];
    
    if ds_exists(tagsUnloaded,ds_type_list)
    {
        for (_tool=0;_tool<ds_list_size(tagsUnloaded);_tool++)
        {
            var tag = tagsUnloaded[| _tool]
            
            //Tool Speed+
            if tag == "Tool Speed+" 
            { 
                tool_firerate = clamp(tool_firerate-(tool_firerate*0.20),1,100);
            }
        }
    }
}

toolFireRate = tool_firerate;
weaponDamage = wep_Dam;
weaponKnockback = wep_Knock;
pick_damage = pick_Dam;
pickLevel = pick_level;
