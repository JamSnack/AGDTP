///scr_checkCraftingType(itemID);
//Returns true if the item is not filtered.

var returnID = false;


//---------RESOURCES-------------
/*if craft_filter_resources == false
{
    switch argument0
    {
        case ITEMID.item_sweetComb: { returnID = ITEMTYPE.def; } break;
    }
}*/

//---------WEAPONS----------
if craft_filter_weapon == false
{
    switch argument0
    {
        case ITEMID.weapon_greenSword: { returnID = ITEMTYPE.weapon; } break;
        case ITEMID.weapon_acornRifle: { returnID = ITEMTYPE.weapon; } break;
        case ITEMID.weapon_subLimeMachineGun: { returnID = ITEMTYPE.weapon; } break;
        case ITEMID.weapon_beemerang: { returnID = ITEMTYPE.weapon; } break;
        case ITEMID.weapon_waterGun: { returnID = ITEMTYPE.weapon; } break;
        case ITEMID.weapon_seashellSpear: { returnID = ITEMTYPE.weapon; } break;
        case ITEMID.weapon_sandySeadollar: { returnID = ITEMTYPE.weapon; } break;
        case ITEMID.weapon_meloniteBow: { returnID = ITEMTYPE.weapon; } break;
    }
}

//---------PICKAXE----------
if craft_filter_pickaxe == false
{
    switch argument0
    {
        case ITEMID.pickaxe_greenPickaxe: { returnID = ITEMTYPE.pickaxe; } break;
        case ITEMID.pickaxe_stingerDrill: { returnID = ITEMTYPE.pickaxe; } break;
        case ITEMID.pickaxe_seashellPickaxe: { returnID = ITEMTYPE.pickaxe; } break;
    }
}

//---------CONSUMABLES-------
if craft_filter_cons == false
{
    switch argument0
    {
        case ITEMID.cons_gremTalisman: { returnID = ITEMTYPE.consumable; } break;
        case ITEMID.cons_bomb: { returnID = ITEMTYPE.consumable; } break;
    }
}

//---------PLRTILES-------------
if craft_filter_plrtile == false
{
    switch argument0
    {
        case ITEMID.tile_ladder: { returnID = ITEMTYPE.playertile; } break;
        case ITEMID.tile_woodenStilt: { returnID = ITEMTYPE.playertile; } break;
        case ITEMID.tile_packedDirt: { returnID = ITEMTYPE.playertile; } break;
        case ITEMID.tile_copperTurret: { returnID = ITEMTYPE.playertile; } break;
        case ITEMID.tile_platform: { returnID = ITEMTYPE.playertile; } break;
        case ITEMID.tile_packedStone: { returnID = ITEMTYPE.playertile; } break;
        case ITEMID.tile_battery: { returnID = ITEMTYPE.playertile; } break;
        case ITEMID.tile_beeTurret: { returnID = ITEMTYPE.playertile; } break;
        case ITEMID.tile_copperBlock: { returnID = ITEMTYPE.playertile; } break;
        case ITEMID.tile_grillBlock: { returnID = ITEMTYPE.playertile; } break;
        case ITEMID.tile_rebarRailgun: { returnID = ITEMTYPE.playertile; } break;
    }
}


//---------ACCESSORIES-------------
if craft_filter_acc == false
{
    switch argument0
    {
        case ITEMID.acc_copperCompass: { returnID = ITEMTYPE.accessory; } break;
        case ITEMID.acc_beehiveBackpack: { returnID = ITEMTYPE.accessory; } break;
        case ITEMID.acc_copperChestplate: { returnID = ITEMTYPE.accessory; } break;
        case ITEMID.acc_metalCompass: { returnID = ITEMTYPE.accessory; } break;
        case ITEMID.acc_copperSlingDrive: { returnID = ITEMTYPE.accessory; } break;
    }
}


return returnID;
