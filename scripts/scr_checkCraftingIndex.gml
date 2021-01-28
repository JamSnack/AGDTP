///scr_checkCraftingList(itemID);
//Returns true if the item is on the list.

var returnID = false;

switch argument0
{
    case ITEMID.tile_ladder: { returnID = true; } break;
    case ITEMID.tile_woodenStilt: { returnID = true; } break;
    case ITEMID.weapon_greenSword: { returnID = true; } break;
    case ITEMID.pickaxe_greenPickaxe: { returnID = true; } break;
    case ITEMID.tile_packedDirt: { returnID = true; } break;
    case ITEMID.tile_copperTurret: { returnID = true; } break;
    case ITEMID.cons_gremTalisman: { returnID = true; } break;
    case ITEMID.tile_platform: { returnID = true; } break;
    case ITEMID.cons_bomb: { returnID = true; } break;
    case ITEMID.tile_packedStone: { returnID = true; } break;
    case ITEMID.tile_battery: { returnID = true; } break;
    case ITEMID.weapon_acornRifle: { returnID = true; } break;
}

//NILMERG
if kingDied_1 == true
{
    switch argument0
    {
        case ITEMID.pickaxe_stingerDrill: { returnID = true; } break;
        case ITEMID.acc_beehiveBackpack: { returnID = true; } break;
        case ITEMID.weapon_beemerang: { returnID = true; } break;
    }
}


return returnID;
