///scr_get_tile_range(itemID/obj);
//Returns a turret (or other) tile's attack range.
switch argument0
{
    case ITEMID.tile_rebarRailgun:
    case ITEMID.tile_copperTurret: { return 7*16; } break;
    case ITEMID.tile_beeTurret: { return 6*16; } break;
    
    default: { return 0; }
}
