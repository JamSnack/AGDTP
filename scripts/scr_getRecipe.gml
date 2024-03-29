///scr_getRecipe(item_id);
//sets the materials and amounts needed to craft an item.

/*
NOTE: these variables must be initialized before calling scr_getRecipe:

mats; // What type of material to look for
matsAmt; // How much of the material to look for/consume. Use -1 for item types that have no amount.
itemID = 0; //The ID of the item to craft.
*/
cost = 0;

switch argument0
{
    case ITEMID.tile_packedDirt: { mats[0] = 1; matsAmt[0] = 5; itemAmt = 1; itemType = 3;} break;
    case ITEMID.weapon_greenSword: { mats[0] = ITEMID.item_copperOre; matsAmt[0] = 8; mats[1] = 9; matsAmt[1] = 5; itemAmt = 0; itemType = 1;} break;
    case ITEMID.pickaxe_greenPickaxe: { mats[0] = ITEMID.item_copperOre; matsAmt[0] = 10; mats[1] = 9; matsAmt[1] = 5; itemAmt = 0; itemType = 2;} break;
    case ITEMID.pickaxe_stingerDrill: { mats[0] = ITEMID.item_copperOre; matsAmt[0] = 20; mats[1] = ITEMID.item_sweetComb; matsAmt[1] = 8; itemAmt = 0; itemType = 2;} break;
    case ITEMID.pickaxe_seashellPickaxe: { mats[0] = ITEMID.item_copperOre; matsAmt[0] = 5; mats[1] = ITEMID.item_seashellMetal; matsAmt[1] = 15; mats[2] = ITEMID.item_stick; matsAmt[2] = 5; itemAmt = 0; itemType = 2;} break;
    case ITEMID.tile_copperTurret: { mats[0] = ITEMID.item_copperOre; matsAmt[0] = 4; mats[1] = 9; matsAmt[1] = 5; itemAmt = 1; itemType = 3; } break;
    case ITEMID.tile_ladder: { mats[0] = 9; matsAmt[0] = 2; itemID = 13; itemAmt = 1; itemType = 3; } break;
    case ITEMID.cons_gremTalisman: { cost = 25; itemAmt = 1; itemType = 4; } break;
    case ITEMID.tile_platform: { mats[0] = 9; matsAmt[0] = 2; itemID = 16; itemAmt = 1; itemType = 3; } break;
    case ITEMID.cons_bomb: { mats[0] = ITEMID.item_stonePiece; matsAmt[0] = 8; mats[1] = ITEMID.item_copperOre; matsAmt[1] = 2; cost = 5; itemAmt = 1; itemType = 4; } break;
    case ITEMID.tile_packedStone: { mats[0] = 8; matsAmt[0] = 5; itemID = 18; itemAmt = 1; itemType = 3;} break;
    case ITEMID.tile_modBench: { cost = 30; mats[0] = ITEMID.item_copperOre; matsAmt[0] = 15; itemAmt = 1; itemType = 3;} break;
    case ITEMID.tile_woodenStilt: { mats[0] = ITEMID.item_stick; matsAmt[0] = 2; itemAmt = 2; itemType = 3;} break;
    case ITEMID.tile_battery: { mats[0] = ITEMID.item_copperOre; matsAmt[0] = 5; cost = 5; itemAmt = 1; itemType = 3;} break;
    case ITEMID.weapon_acornRifle: { mats[0] = ITEMID.item_copperOre; matsAmt[0] = 6; mats[1] = ITEMID.item_acorn; matsAmt[1] = 8; mats[2] = ITEMID.item_stick; matsAmt[2] = 36; itemAmt = 0; itemType = ITEMTYPE.weapon;} break;
    case ITEMID.weapon_beemerang: { mats[0] = ITEMID.item_copperOre; matsAmt[0] = 15; mats[1] = ITEMID.item_sweetComb; matsAmt[1] = 6; itemAmt = 0; itemType = ITEMTYPE.weapon;} break;
    case ITEMID.acc_beehiveBackpack: { mats[0] = ITEMID.item_sweetComb; matsAmt[0] = 15; itemAmt = 0; itemType = ITEMTYPE.accessory;} break;
    case ITEMID.acc_copperChestplate: { mats[0] = ITEMID.item_copperOre; matsAmt[0] = 20; itemAmt = 0; itemType = ITEMTYPE.accessory;} break;
    case ITEMID.tile_beeTurret: { mats[0] = ITEMID.item_copperOre; matsAmt[0] = 1; mats[1] = ITEMID.item_sweetComb; matsAmt[1] = 2; itemAmt = 1; itemType = ITEMTYPE.playertile;} break;
    case ITEMID.tile_grillBlock: { mats[0] = ITEMID.tile_copperBlock; matsAmt[0] = 1; cost = 40; itemAmt = 1; itemType = ITEMTYPE.playertile; } break;
    case ITEMID.tile_copperBlock: { mats[0] = ITEMID.item_copperOre; matsAmt[0] = 4; itemAmt = 1; itemType = ITEMTYPE.playertile; } break;
    case ITEMID.weapon_subLimeMachineGun: { mats[0] = ITEMID.item_copperOre; matsAmt[0] = 10; mats[1] = ITEMID.cons_treeFruit; matsAmt[1] = 5; itemAmt = 0; itemType = ITEMTYPE.weapon; } break;
    case ITEMID.weapon_waterGun: { mats[0] = ITEMID.item_seashellMetal; matsAmt[0] = 25; itemAmt = 0; itemType = ITEMTYPE.weapon; } break;
    case ITEMID.weapon_seashellSpear: { mats[0] = ITEMID.item_seashellMetal; matsAmt[0] = 20; mats[1] = ITEMID.item_stick; matsAmt[1] = 5; itemAmt = 0; itemType = ITEMTYPE.weapon; } break;
    case ITEMID.tile_rebarRailgun: { mats[0] = ITEMID.item_seashellMetal; matsAmt[0] = 8; mats[1] = 9; matsAmt[1] = 5; itemAmt = 1; itemType = 3; } break;
    case ITEMID.weapon_sandySeadollar: { mats[0] = ITEMID.item_seashellMetal; matsAmt[0] = 20; mats[1] = ITEMID.item_dirtClump; matsAmt[1] = 50; itemAmt = 0; itemType = ITEMTYPE.weapon;} break;
    case ITEMID.acc_copperCompass: { cost = 75; mats[0] = ITEMID.item_copperOre; matsAmt[0] = 12; itemAmt = 0; itemType = ITEMTYPE.accessory; } break;
    case ITEMID.acc_metalCompass: { cost = 175; mats[0] = ITEMID.acc_copperCompass; matsAmt[0] = -1; mats[1] = ITEMID.item_seashellMetal; matsAmt[1] = 12; itemAmt = 0; itemType = ITEMTYPE.accessory; } break;
    case ITEMID.acc_copperSlingDrive: { cost = 100; mats[0] = ITEMID.item_copperOre; matsAmt[0] = 8; mats[1] = ITEMID.item_stick; matsAmt[1] = 25; itemAmt = 0; itemType = ITEMTYPE.accessory; } break;
    case ITEMID.acc_seashellSlingDrive: { cost = 300; mats[0] = ITEMID.item_seashellMetal; matsAmt[0] = 10; mats[1] = ITEMID.item_copperOre; matsAmt[1] = 5; mats[2] = ITEMID.item_stick; matsAmt[2] = 25; itemAmt = 0; itemType = ITEMTYPE.accessory; } break;
    case ITEMID.weapon_meloniteBow: { cost = 0; mats[0] = ITEMID.item_melonite; matsAmt[0] = 12; mats[1] = ITEMID.item_stick; matsAmt[1] = 25; itemAmt = 0; itemType = ITEMTYPE.weapon; } break;
    case ITEMID.weapon_meloniteChainsaw: { cost = 0; mats[0] = ITEMID.item_melonite; matsAmt[0] = 14; mats[1] = ITEMID.item_seashellMetal; matsAmt[1] = 5; mats[2] = ITEMID.item_stick; matsAmt[2] = 20; itemAmt = 0; itemType = ITEMTYPE.weapon; } break;
    case ITEMID.acc_meloniteSlingDrive: { cost = 550; mats[0] = ITEMID.item_melonite; matsAmt[0] = 8; mats[1] = ITEMID.item_seashellMetal; matsAmt[1] = 4; itemAmt = 0; itemType = ITEMTYPE.weapon; } break;
}
