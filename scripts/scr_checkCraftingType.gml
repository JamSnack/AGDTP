///scr_checkCraftingType(itemID);
//Returns true if the item is not filtered.

var returnID = false;

//---------WEAPONS----------
if craft_filter_weapon == false
{
    switch argument0
    {
        case ITEMID.weapon_greenSword: { returnID = true; } break;
        case ITEMID.weapon_acornRifle: { returnID = true; } break;
    }
}

//---------PICKAXE----------
if craft_filter_weapon == false
{
    switch argument0
    {
        case ITEMID.pickaxe_greenPickaxe: { returnID = true; } break;
        case ITEMID.cons_bomb: { returnID = true; } break;
    }
}

//---------CONSUMABLES-------
if craft_filter_weapon == false
{
    switch argument0
    {
        case ITEMID.cons_gremTalisman: { returnID = true; } break;
    }
}

//---------PLRTILES-------------
if craft_filter_plrtile == false
{
    switch argument0
    {
        case ITEMID.tile_ladder: { returnID = true; } break;
        case ITEMID.tile_woodenStilt: { returnID = true; } break;
        case ITEMID.tile_packedDirt: { returnID = true; } break;
        case ITEMID.tile_copperTurret: { returnID = true; } break;
        case ITEMID.tile_platform: { returnID = true; } break;
        case ITEMID.tile_packedStone: { returnID = true; } break;
        case ITEMID.tile_battery: { returnID = true; } break;
    }
}

//WIP: ACCESSORIES

return returnID;
