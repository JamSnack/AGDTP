///scr_drawToolTip(item_id, item_type, crafting_menu);
text[0] = ""; //Item Name
text[1] = ""; //Item Description
text[2] = ""; //Tag descriptions

var item_id = argument0;
var item_type = argument1;
var crafting_menu = argument2; //Bool. Whether or not the script is being used to display text inside the crafting menu.

/*##############text[1] CONVENTIONS##################

WEAPON:
Damage: 4#Cooldown: 1#Knockback: 1#Desc."

PICKAXE:
Tier: 0#Cooldown: 1#Power: 1#Desc.

TILE:
Health: hp+(maxHp*(tileLevel/100));

ACCESSORY:
Slot Cost: 1

LINKS:
scr_applyWeaponStats();
scr_applyPiackaxeStats();
scr_applyAccessory();
*/

//MEANT FOR USE INSIDE hudControl!!!

if crafting_menu == false
{
    switch item_type
    {
        case ITEMTYPE.def:
        {
            text[1] += "Resource##";
        }
        break;
    
        case ITEMTYPE.weapon:
        {
            text[1] += ("Weapon##Damage: "+string(obj_player.weaponDamage)+"#Cooldown: "+string(obj_player.toolFireRate)+"#Knockback: "+string(obj_player.weaponKnockback));
        }
        break;
        
        case ITEMTYPE.pickaxe:
        {
            text[1] += ("Pickaxe##Tier: "+string(obj_player.pickLevel)+"#Cooldown: "+string(obj_player.toolFireRate)+"#Power: "+string(obj_player.pickDamage));
        }
        break;
        
        case ITEMTYPE.playertile:
        {
            var _hp = scr_invenTileHealthIndex(argument0);
            text[1] += ("Tile##Health: "+string(_hp+(_hp*tileLevel/50)));
        }
        break;
        
        case ITEMTYPE.accessory:
        {
            text[1] += ("Accessory##");//Slot Cost: "+string(scr_getSlotCost(argument0)))
        }
        break;
        
        case ITEMTYPE.consumable:
        {
            text[1] += ("Consumable##");
        }
        break;
    }
}
else
{
    scr_getToolStats(item_id);

    switch item_type
    {
        case ITEMTYPE.def:
        {
            text[1] += "Resource##";
        }
        break;
    
        case ITEMTYPE.weapon:
        {
            text[1] += ("Weapon##Damage: "+string(weaponDamage)+"#Cooldown: "+string(toolFireRate)+"#Knockback: "+string(weaponKnockback));
        }
        break;
        
        case ITEMTYPE.pickaxe:
        {
            text[1] += ("Pickaxe##Tier: "+string(pickLevel)+"#Cooldown: "+string(toolFireRate)+"#Power: "+string(pick_damage));
        }
        break;
        
       case ITEMTYPE.playertile:
        {
            var _hp = scr_invenTileHealthIndex(item_id);
            text[1] += ("Tile##Health: "+string(_hp+(_hp*tileLevel/50)));
        }
        break;
        
        case ITEMTYPE.accessory:
        {
            text[1] += ("Accessory#");//Slot Cost: "+string(scr_getSlotCost(item_id)))
        }
        break;
        
        case ITEMTYPE.consumable:
        {
            text[1] += ("Consumable##");
        }
        break;
    }
}

text[1]+="##";

switch item_id
{
    default: { text[0] = ""; text[1] += ""; } break;
    case 1: { text[0] = "Dirt Clump"; text[1] += "A clump of dirt. Perhaps it can be used to make a primitive shelter!"; } break; //Dirt Clump
    case 2: { text[0] = "Green Sword"; text[1] += "Green mean and fast!"; } break; //Green Sword
    case 3: { text[0] = "Dull Sword"; text[1] += "Used to deathpoke the gremlins."; } break; //Dull Sword
    case 4: { text[0] = "Dull Pickaxe"; text[1] += "Perhaps you could collect some dirt with this."; } break; //Dull Pick
    case 5: { text[0] = "Green Pickaxe"; text[1] += "Excellent for mining!"; } break; //Green Pick
    case 6: { text[0] = "Packed Dirt"; text[1] += "Weak, defensive tile. Useful for quickly building a base."; } break;
    case 7: { text[0] = "Workbench"; text[1] += "Use this to craft basic items and structures!"; } break;
    case 8: { text[0] = "Stone Piece"; text[1] += "Ha ha yes!"; } break;
    case 9: { text[0] = "Stick"; text[1] += "Basic crafting material. Even gremlins could use this!"; } break;
    case 10: { text[0] = "Copper Ore"; text[1] += "Basic crafting material. A building block of nature!"; } break;
    case 11: { text[0] = "Wooden Bow"; text[1] += "Shoot arrows at far enemies."; } break;
    case 12: { text[0] = "Copper Turret"; text[1] += "A turret that converts energy into bullets and automatically attacks Gremlins."; } break;
    case 13: { text[0] = "Ladder"; text[1] += "Latter or ladder?"; } break;
    case 14: { text[0] = "Gremlin Talisman"; text[1] += "Consume to turn the day into night."; } break;
    case 15: { text[0] = "Synthetic Essence"; text[1] += "The core material of the Gremlin menace! I bet it can be used for all sorts of things!"; } break;
    case 16: { text[0] = "Platform"; text[1] += "Useful for building."; } break;
    case 17: { text[0] = "Bomb"; text[1] += "Use this to quickly gather resources."; } break;
    case 18: { text[0] = "Packed Stone"; text[1] += "A reliable, easy-to-gather defense!"; } break;
    case 19: { text[0] = "Sub-Lime Machine Gun"; text[1] += "A reliable, high-firerate fruit!"; } break;
    case ITEMID.item_modTag: { text[0] = "Mod Tag"; text[1] += "Modify your equipment with this tag. Used in the tag menu."; } break;
    case ITEMID.tile_woodenStilt: { text[0] = "Wooden Wall"; text[1] += "Used to connect pieces of your base, creating more elaborate defenses."; } break;
    case ITEMID.item_acorn: { text[0] = "Acorn"; text[1] += "Place this on dirt to grow a tree. Can also be placed on Packed Dirt."; } break;
    case ITEMID.weapon_sphereLauncher: { text[0] = "Sphere Launcher"; text[1] += "He who controls his spheres, controls his destiny."; } break;
    case ITEMID.tile_modBench: { text[0] = "Mod Bench"; text[1] += "Use this workbench to modify your tools!"; } break;
    case ITEMID.pickaxe_stingerDrill: { text[0] = "Stinger Drill"; text[1] += "Nilmerg's stinger."; } break;
    case ITEMID.weapon_beemerang: { text[0] = "Beemerang"; text[1] += "A home-bound friend."; } break;
    case ITEMID.acc_ultrablueStar: { text[0] = "Ultra-Blue Star"; text[1] += "Increases knockback resistance by 0.6#Knockback resistance: "+string(obj_player.knock_resistance); } break;
    case ITEMID.acc_satchel: {text[0] = "Essential Satchel-Pack"; text[1] += "Increases inventory size by 4." } break;
    case ITEMID.tile_battery: { text[0] = "Battery"; text[1] += "Place within 8 tiles of the pie to charge over time. Energy is distributed when needed. Holds 8 energy."; } break;
    case ITEMID.acc_beehiveBackpack: { text[0] = "Beehive Backpack"; text[1] += "Increase jump-height by 1 tile."; } break;
    case ITEMID.cons_treeFruit: { text[0] = "Tree Fruit"; text[1] += "A delectable little snack! Heals 10 HP."; } break;
    case ITEMID.weapon_acornRifle: { text[0] = "Acorn Rifle"; text[1] += "A true marksman's humble beginning."; } break;
    case ITEMID.item_sweetComb: { text[0] = "Sweet Comb"; text[1] += "The prized treasure of the bees."; } break; 
    case ITEMID.item_seashellMetal: { text[0] = "Seashell Metal"; text[1] += "A hard, lustrous seashell."; } break;
    case ITEMID.tile_beeTurret: { text[0] = "Bee Hive Turret"; text[1] += "'Yeah get 'em yeah'"; } break; 
    case ITEMID.tile_rebarRailgun: { text[0] = "Rebar Railgun"; text[1] += "Fires a burst of lasers that pierce enemies and shields."; } break;
    case ITEMID.tile_grillBlock: { text[0] = "Grill Block"; text[1] += "Heats up, hurting nearby enemies!"; } break;
    case ITEMID.tile_copperBlock: { text[0] = "Copper Block"; text[1] += "Truly a stalwart defense."; } break;
    case ITEMID.weapon_waterGun: { text[0] = "Water Gun"; text[1] += "Blast your enemies with high-pressure water blasts!"; } break;
    case ITEMID.weapon_seashellSpear: { text[0] = "Seashell Spear"; text[1] += "WARNING: Extremely sharp."; } break;
    case ITEMID.acc_copperChestplate: { text[0] = "Copper Chestplate"; text[1] += "Protects your body.#+20 Max HP."; } break;
    case ITEMID.weapon_sandySeadollar: { text[0] = "Sandy Seadollar"; text[1] += "A creature of the ocean, or a creature of the sky?"; } break;
    case ITEMID.pickaxe_seashellPickaxe: { text[0] = "Seashell-Metal Pickaxe"; text[1] += "A strong pickaxe made out of the metals of the sea."; } break;
    case ITEMID.acc_copperCompass: { text[0] = "Copper Compass"; text[1] += "Provides guidance in the underground Grasslands."; } break;
    case ITEMID.acc_metalCompass: { text[0] = "Metal Compass"; text[1] += "Provides guidance in the underground Coral Cove and in lower regions."; } break;
    case ITEMID.acc_copperSlingDrive: { text[0] = "Copper Sling-Drive"; text[1] += "Cooldown: 60#Force: 5#Jumps: 1#Press "+scr_get_character(global.key_sling)+" to perform a dash."; } break;
    case ITEMID.acc_seashellSlingDrive: { text[0] = "Seashell-Metal Sling-Drive"; text[1] += "Cooldown: 52#Force: 6#Jumps: 1#Press "+scr_get_character(global.key_sling)+" to perform a dash."; } break;
    case ITEMID.cons_melonChunk: { text[0] = "Melon Chunk"; text[1] += "A small snack to help quickly get you back in the fight! Heals 5 HP."; } break;
    case ITEMID.item_melonite: { text[0] = "Melonite"; text[1] += "A hard resin pulled from the carnage of the Melon Bloom's terror."; } break;
    case ITEMID.weapon_meloniteBow: { text[0] = "Melonite Bow"; text[1] += "Fires arrows at an incredible velocity."; } break;
    case ITEMID.weapon_meloniteChainsaw: { text[0] = "Melonite Chainsaw"; text[1] += "Rip through hordes of Gremlins."; } break;
    case ITEMID.acc_meloniteSlingDrive: { text[0] = "Melonite Sling-Drive"; text[1] += "Cooldown: 50#Force: 7#Jumps: 2#Press "+scr_get_character(global.key_sling)+" to perform a dash."; } break;
}

//-TAG DESCRIPTIONS;
/*
----------DESCRIPTION NOTATION------------
On projectile hit: effect
On enemy killed: effect
Projectile effect: effect
Stat Effect: effect
*/

//TAG TEXT
/*
var tagsUnloaded = "";
if selectedSlot != noone { tagsUnloaded = inventorySlotTags[selectedSlot]; }


if ds_exists(tagsUnloaded,ds_type_list)
{
    for (_l=0;_l<ds_list_size(tagsUnloaded);_l++)
    {
        //Title of the tag.
        var text_buffer = "";
        var tag = tagsUnloaded[| _l];
        
        if !is_string(tag) then break;
        
        //Check to see if we're adding a new description to text[2];
        if (_l > 0 && tagsUnloaded[| _l] != tagsUnloaded[| _l-1]) || (_l == 0)
        { 
            text_buffer = tagsUnloaded[| _l]+":#"; 
            
            switch tagsUnloaded[| _l]
            {
            //Increases projectile speed
                case "Bouncy": { text_buffer += "Projectile Effect: Projectiles will bounce off of hard surfaces."; } break;
                case "Hive": {text_buffer += "On Enemy Hit: Spawns a stinger that deals half the tool's damage."; } break;
                case "Tool Speed+": {text_buffer = "Decreases a tool's cooldown by 20%."} break;
                case "Grenade": {text_buffer += "Has a 20% chance to turn killed enemies into a bomb. Bomb damage is half your tool damage."} break;
                case "Bright": { text_buffer += "Increases the player's brightness when held."; } break;
                case "Split": { text_buffer += "Projectile Effect: Splits a projectile into two weaker ones on collision."; } break;
            }
        }
        else
        //If we aren't adding a new description, add something else.
        { 
            //If the tags are the same, add a "x2"
            if _l > 0 && tag == tagsUnloaded[| _l-1]
            {
                text_buffer = "#x2";
            }
        }
        
        //Apply description
        text_buffer = scr_fitText(text_buffer,30);
        text[2] += text_buffer+"#";
    }
}
