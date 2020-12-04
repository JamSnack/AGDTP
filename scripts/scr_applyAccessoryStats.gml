///scr_applyAccessoryStats(accessory,equip);
//This will mainly be used to equip all accessory stats when transitioning rooms.
var accessory = argument0;
var equip = argument1;

switch accessory
{    
    case ITEMID.acc_ultrablueStar: { knock_resistance += 0.6*equip; } break;
}

