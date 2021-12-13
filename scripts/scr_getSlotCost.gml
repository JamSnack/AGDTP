///scr_getSlotCost(accessory);
//Returns the slot cost of an accessory.
//NOTE: 11/9/2021 Slot cost has been removed as a mechanic. This script now serves as a 
//precautionary measure to ensure random items can NOT be equipped
switch argument0
{
    case ITEMID.acc_ultrablueStar:
    case ITEMID.acc_satchel:
    case ITEMID.acc_beehiveBackpack:
    case ITEMID.acc_copperCompass:
    case ITEMID.acc_metalCompass:
    case ITEMID.acc_copperChestplate: { return 0; } break;
    default: { print("ERROR: EQUIP IS NOT ACCESSORY"); scr_hudMessage("ERROR: EQUIP IS NOT ACCESSORY#Cool bug bro",global.fnt_menu,4,0,c_red,0); return 999; } break;
}
