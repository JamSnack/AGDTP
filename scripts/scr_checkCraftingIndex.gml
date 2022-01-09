///scr_checkCraftingList(itemID);
//Returns true for an item if its blueprint is unlocked.

var returnID = false;

switch argument0
{
    case ITEMID.tile_ladder: { returnID = true; } break;
    case ITEMID.tile_woodenStilt: { returnID = true; } break;
    case ITEMID.tile_packedDirt: { returnID = true; } break;
    case ITEMID.cons_gremTalisman: { returnID = true; } break;
    case ITEMID.tile_platform: { returnID = true; } break;
    case ITEMID.cons_bomb: { returnID = true; } break;
    case ITEMID.tile_packedStone: { returnID = true; } break;
    case ITEMID.weapon_acornRifle: { returnID = true; } break;
}

//copper ore
if recipe_copperOre == true
{
    switch argument0
    {
        case ITEMID.tile_battery: { returnID = true; } break;
        case ITEMID.tile_copperTurret: { returnID = true; } break;
        case ITEMID.acc_copperChestplate: { returnID = true; } break;
        case ITEMID.acc_copperCompass: { returnID = true; } break;
        case ITEMID.tile_copperBlock: { returnID = true; } break;
        case ITEMID.weapon_greenSword: { returnID = true; } break;
        case ITEMID.weapon_subLimeMachineGun: { returnID = true; } break;
        case ITEMID.pickaxe_greenPickaxe: { returnID = true; } break;
        case ITEMID.acc_copperSlingDrive: { returnID = true; } break;
    }
}

//sweet comb
if recipe_sweetComb == true
{
    switch argument0
    {
        case ITEMID.pickaxe_stingerDrill: { returnID = true; } break;
        case ITEMID.acc_beehiveBackpack: { returnID = true; } break;
        case ITEMID.weapon_beemerang: { returnID = true; } break;
        case ITEMID.tile_beeTurret: {returnID = true; } break;
        case ITEMID.tile_grillBlock: { returnID = true; } break;
    }
}

//seashell metal
if recipe_seashellMetal == true
{
    switch argument0
    {
        case ITEMID.weapon_waterGun: { returnID = true; } break;
        case ITEMID.tile_rebarRailgun: { returnID = true; } break;
        case ITEMID.weapon_seashellSpear: { returnID = true; } break;
        case ITEMID.pickaxe_seashellPickaxe: { returnID = true; } break;
        case ITEMID.weapon_sandySeadollar: { returnID = true; } break;
        case ITEMID.acc_metalCompass: { returnID = true; } break;
    }
}

//melonite
if recipe_melonite == true
{
    switch argument0
    {
        case ITEMID.weapon_meloniteBow: { returnID = true; } break;
    }
}


return returnID;
