///scr_getSlotCost(accessory);
//Returns the slot cost of an accessory.
switch argument0
{
    case ITEMID.acc_ultrablueStar: { return 3; } break;
    case ITEMID.acc_satchel: { return 0; } break;
    case ITEMID.acc_beehiveBackpack: { return 0; } break;
    case ITEMID.acc_copperChestplate: { return 0; } break;
    default: { scr_hudMessage("ERROR: EQUIP IS NOT ACCESSORY#Cool bug bro",global.fnt_menu,4,0,c_red,0); return 999; } break;
}
