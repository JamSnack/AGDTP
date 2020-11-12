///scr_drawToolTip(itemID);
text[0] = "" //Item Name
text[1] = ""; //Item Description

switch argument0
{
    default: { text[0] = "NIL"; text[1] = "WIP"; } break;
    case 1: { text[0] = "Dirt Clump"; text[1] = "A clump of dirt.#Perhaps it can be used to make a#primitive shelter!"; } break; //Dirt Clump
    case 2: { text[0] = "Green Sword"; text[1] = "Damage: 6#Speed: 2#Green mean and fast!"; } break; //Green Sword
    case 3: { text[0] = "Dull Sword"; text[1] = "Damage: 4#Speed: 1#Slow and nearly useless."; } break; //Dull Sword
    case 4: { text[0] = "Dull Pickaxe"; text[1] = "Tier: 0#Speed: 1#Perhaps you could collect#some dirt with this."; } break; //Dull Pick
    case 5: { text[0] = "Green Pickaxe"; text[1] = "Tier: 0#Speed: 2#Excellent for mining#uselss items!"; } break; //Green Pick
    case 6: { text[0] = "Packed Dirt"; text[1] = "Player Defense#Weak, defensive tile#used to build#a base quickly!"; } break;
    case 7: { text[0] = "Workbench"; text[1] = "Use this to craft#basic items#and structures!"; } break;
    case 8: { text[0] = "Stone Piece"; text[1] = "Ha ha yes!"; } break;
    case 9: { text[0] = "Stick"; text[1] = "Basic crafting material.#Even gremlins could#use this!"; } break;
    case 10: { text[0] = "Copper Ore"; text[1] = "Basic crafting material.#A building block#of nature!"; } break;
    case 11: { text[0] = "Weak Bow"; text[1] = "Damage: 3#Firerate: 0.58#Hit far away#enemies!"; } break;
    case 12: { text[0] = "Copper Turret"; text[1] = "Damage: 1#Firerate: 1#Health: 5#Automatically shoots#at Gremlins!"; } break;
    case 13: { text[0] = "Ladder"; text[1] = "Climb this. Do it."; } break;
    case 14: { text[0] = "Gremlin Talisman"; text[1] = "Consume this to skip a wave."; } break;
    case 15: { text[0] = "Synthetic Essence"; text[1] = "It feels rubbery,# but is also a#liquid!"; } break;
    case 16: { text[0] = "Platform"; text[1] = "Useful for building!"; } break;
    case 17: { text[0] = "Bomb"; text[1] = "Use this to#quickly gather#resources!"; } break;
    case 18: { text[0] = "Packed Stone"; text[1] = "A reliable,#easy-to-gather defense!"; } break;
    case 19: { text[0] = "Sub-Lime Machine#Gun"; text[1] = "Damage: 3#Firerate: 0.16#A reliable,#high-firerate fruit!"; } break;
    case ITEMID.item_modTag: { text[0] = "Mod Tag"; text[1] = "Modify your equipment#with this tag.##Used at a Mod Bench."; } break;
    case ITEMID.item_acorn: { text[0] = "Acorn"; text[1] = "Place this on dirt to grow a tree!"; } break;
    case ITEMID.weapon_sphereLauncher: { text[0] = "Sphere Launcher"; text[1] = "Damage: 4#Firerate: 0.75#He who controls his spheres,#controls his destiny."; } break;
    case ITEMID.tile_modBench: { text[0] = "Mod Bench"; text[1] = "Use this workbench to modify#your tools!"; } break;
}
