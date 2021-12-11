///scr_applyAccessoryStats(accessory,equip);
//This will mainly be used to equip all accessory stats when transitioning rooms.
var accessory = argument0;
var equip = argument1;


//Accessories that affect the inventory
/*switch accessory
{    
    case ITEMID.acc_satchel: { maxInvenSlots += 4*equip; } break;
    case ITEMID.acc_beehiveBackpack: { maxInvenSlots += 2*equip; } break;
}*/

//Acessories that affect stats
if instance_exists(obj_player)
{
    switch accessory
    {    
        case ITEMID.acc_ultrablueStar: { obj_player.knock_resistance += 0.6*equip; } break;
        case ITEMID.acc_beehiveBackpack: { obj_player.vsp_jump -= 1*equip; } break;
        case ITEMID.acc_copperChestplate: { obj_player.maxHp += 20*equip; } break;
        case ITEMID.acc_copperCompass: { obj_player.compass_level = 1*equip; } break;
    }
}

