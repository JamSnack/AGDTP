///scr_drawToolTip(itemID);
text[0] = "" //Item Name
text[1] = ""; //Item Description

/*##############text[1] CONVENTIONS##################

WEAPON:
Damage: 4#Cooldown: 1#Knockback: 1#Desc."

PICKAXE:
Tier: 0#Cooldown: 1#Power: 1#Desc.

LINKS:
scr_applyWeaponStats();
scr_applyPiackaxeStats();
*/

switch hudControl.inventorySlotType[selectedSlot]
{
    case ITEMTYPE.weapon:
    {
        text[1] = ("Damage: "+string(obj_player.weaponDamage)+"#Cooldown: "+string(obj_player.toolFireRate)+"#Knockback: "+string(obj_player.weaponKnockback));
    }
    break;
    
    case ITEMTYPE.pickaxe:
    {
        text[1] = ("Tier: "+string(obj_player.pickLevel)+"#Cooldown: "+string(obj_player.toolFireRate)+"#Power: "+string(obj_player.pickDamage));
    }
}


switch argument0
{
    default: { text[0] = ""; text[1] = ""; } break;
    case 1: { text[0] = "Dirt Clump"; text[1] = "A clump of dirt.#Perhaps it can be used to make a#primitive shelter!"; } break; //Dirt Clump
    case 2: { text[0] = "Green Sword"; text[1] += "#Green mean and fast!"; } break; //Green Sword
    case 3: { text[0] = "Dull Sword"; text[1] += "#Used to deathpoke the gremlins."; } break; //Dull Sword
    case 4: { text[0] = "Dull Pickaxe"; text[1] += "#Perhaps you could collect#some dirt with this."; } break; //Dull Pick
    case 5: { text[0] = "Green Pickaxe"; text[1] += "#Excellent for mining!"; } break; //Green Pick
    case 6: { text[0] = "Packed Dirt"; text[1] = "Player Defense#Weak, defensive tile#used to build#a base quickly!"; } break;
    case 7: { text[0] = "Workbench"; text[1] = "Use this to craft#basic items#and structures!"; } break;
    case 8: { text[0] = "Stone Piece"; text[1] = "Ha ha yes!"; } break;
    case 9: { text[0] = "Stick"; text[1] = "Basic crafting material.#Even gremlins could#use this!"; } break;
    case 10: { text[0] = "Copper Ore"; text[1] = "Basic crafting material.#A building block#of nature!"; } break;
    case 11: { text[0] = "Weak Bow"; text[1] += "#Hit far away#enemies!"; } break;
    case 12: { text[0] = "Copper Turret"; text[1] = "Damage: 10#Cooldown: 0.8#Health: 15#Automatically shoots#at Gremlins!"; } break;
    case 13: { text[0] = "Ladder"; text[1] = "Climb this. Do it."; } break;
    case 14: { text[0] = "Gremlin Talisman"; text[1] = "Consume this to skip a wave."; } break;
    case 15: { text[0] = "Synthetic Essence"; text[1] = "It feels rubbery,# but is also a#liquid!"; } break;
    case 16: { text[0] = "Platform"; text[1] = "Useful for building!"; } break;
    case 17: { text[0] = "Bomb"; text[1] = "Consumed on use.#Use this to#quickly gather#resources!"; } break;
    case 18: { text[0] = "Packed Stone"; text[1] = "A reliable,#easy-to-gather defense!"; } break;
    case 19: { text[0] = "Sub-Lime Machine#Gun"; text[1] += "#A reliable,#high-firerate fruit!"; } break;
    case ITEMID.item_modTag: { text[0] = "Mod Tag"; text[1] = "Modify your equipment#with this tag.##Used at a Mod Bench."; } break;
    case ITEMID.item_acorn: { text[0] = "Acorn"; text[1] = "Place this on dirt to grow a tree!"; } break;
    case ITEMID.weapon_sphereLauncher: { text[0] = "Sphere Launcher"; text[1] += "#He who controls his spheres,#controls his destiny."; } break;
    case ITEMID.tile_modBench: { text[0] = "Mod Bench"; text[1] = "Use this workbench to modify#your tools!"; } break;
    case ITEMID.pickaxe_stingerDrill: { text[0] = "Stinger Drill"; text[1] += "#Nilmerg's stinger."; } break;
    case ITEMID.weapon_beemerang: { text[0] = "Beemerang"; text[1] += "#A home-bound friend."; } break;
}
