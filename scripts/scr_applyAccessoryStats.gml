///scr_applyAccessoryStats(accessory,equip);
//This will mainly be used to equip all accessory stats when transitioning rooms.
var accessory = argument0;
var equip = argument1;

switch accessory
{    
    case ITEMID.acc_ultrablueStar: { obj_player.knock_resistance += 0.6*equip; } break;
    case ITEMID.acc_satchel: { maxInvenSlots += 4*equip; } break;
}

