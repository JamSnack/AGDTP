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
    case ITEMID.acc_copperSlingDrive:
    case ITEMID.acc_seashellSlingDrive:
    case ITEMID.acc_copperChestplate: { return 0; } break;
    case ITEMID.nil: { print("scr_getSlotCost: EQUIP IS NIL"); scr_hudMessage("scr_getSlotCost: EQUIP IS NIL",global.fnt_menu,4,0,c_red,0); return 999;} break;
    default: { print("scr_getSlotCost: EQUIP IS NOT ACCESSORY"); scr_hudMessage("scr_getSlotCost: EQUIP IS NOT ACCESSORY",global.fnt_menu,4,0,c_red,0); return 999; } break;
}
