///scr_craftingToolTip(itemID);
text[0] = "" //Item Name
text[1] = ""; //Item Description

switch argument0
{
    case ITEMID.tile_ladder: { text[0] = "Ladder"; text[1] = "Place this and climb!"; text[2] = "Stick x 2"} break; //Workbench
    case ITEMID.tile_woodenStilt: { text[0] = "Wooden Stilt"; text[1] = "Provides support for your structures."; text[2] = "Stick x 2"} break;
    case ITEMID.weapon_greenSword: { text[0] = "Green Sword"; text[1] = "Damage: 6#Speed: 2"; text[2] = "Copper Ore x 12#Stick x 5"} break; //Green Sword
    case ITEMID.pickaxe_greenPickaxe: { text[0] = "Green Pickaxe"; text[1] = "Tier: 0#Speed: 2"; text[2] = "Copper Ore x 8#Stick x 5" } break; //Green Pick
    case ITEMID.tile_packedDirt: { text[0] = "Packed Dirt"; text[1] = "Health: 10"; text[2] = "Dirt Clump x 4" } break;
    case ITEMID.tile_copperTurret: { text[0] = "Copper Turret"; text[1] = "Health: 5"; text[2] = "Copper Ore x 15#Stick x 5" } break;
    case ITEMID.cons_gremTalisman: { text[0] = "Gremlin Talisman"; text[1] = "Consumable"; text[2] = "Synthetic Essence x 10" } break;
    case ITEMID.tile_platform: { text[0] = "Platform"; text[1] = "Tile"; text[2] = "Stick x 2" } break;
    case ITEMID.cons_bomb: { text[0] = "Token Bomb"; text[1] = "Consumable"; text[2] = "Stone Piece x 10#Synthetic Essence x 2#Copper Ore x 2" } break;
    case ITEMID.tile_packedStone: { text[0] = "Packed Stone"; text[1] = "Health: 25"; text[2] = "Stone Piece x 4" } break;
    case ITEMID.tile_battery: { text[0] = "Battery"; text[1] = "Use this to store energy for later use!"; text[2] = "Synthetic Essence x 5#Copper Ore x 5" } break;
    case ITEMID.weapon_acornRifle: { text[0] = "Acorn Rifle"; text[1] = "Slay your foes with the power of the forest."; text[2] = "Stick x 100#Copper Ore x 10#Acorn x 50" } break;
}
