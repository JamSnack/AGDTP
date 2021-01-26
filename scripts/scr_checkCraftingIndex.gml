///scr_checkCraftingList(itemID);
//Returns true if the item is on the list.

var returnID = false;

switch argument0
{
    case ITEMID.tile_ladder: { returnID = true; } break;
    case ITEMID.tile_woodenStilt: { returnID = true; } break;
}

if (instance_exists(obj_player) && instance_exists(obj_pie) && point_distance(obj_player.x,obj_player.y,obj_pie.x,obj_pie.y) <= 16*4) || room == rm_lobby //If 4 tiles or less away from the pie!
{
    switch argument0
    {
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
}

return returnID;
