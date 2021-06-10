///scr_invenTileIndex(itemID);
//Return the object associated with the itemID of the tile to place.


switch argument0
{
    case 6: { return obj_packedDirt; } break;
    case 7: { return obj_workbench; } break;
    case 12: { return obj_copperTurret; } break;
    case 13: { return obj_ladder; } break;
    case 16: { return obj_platform; } break;
    case 18: { return obj_packedStone; } break;
    case ITEMID.tile_modBench: { return obj_modBench; } break;
    case ITEMID.tile_woodenStilt: { return obj_woodenStilt; } break;
    case ITEMID.item_acorn: { return obj_sapling; } break;
    case ITEMID.tile_battery: { return obj_battery; } break;
    case ITEMID.tile_beeTurret: { return obj_beeTurret; } break;
    case ITEMID.tile_rebarRailgun: { return obj_rebarRailgun; } break;
    case ITEMID.tile_grillBlock: { return obj_grillBlock; } break;
    case ITEMID.tile_copperBlock: { return obj_copperBlock; } break;
}
