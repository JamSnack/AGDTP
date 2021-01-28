///scr_craftItem(itemName)
var mats; // What type of material to look for
var matsAmt; // How much of the material to look for/consume.
var itemID = argument0; //The ID of the item to craft.
var amt_remove; //For material removing purposes.

//ITEMS WITH AN AMOUNT OF '0' CANNOT BE USED AS A MATERIAL YET.

switch itemID
{
    case ITEMID.tile_packedDirt: { mats[0] = 1; matsAmt[0] = 4; itemAmt = 1; itemType = 3;} break;
    case ITEMID.weapon_greenSword: { mats[0] = ITEMID.item_copperOre; matsAmt[0] = 12; mats[1] = 9; matsAmt[1] = 5; itemAmt = 0; itemType = 1;} break;
    case ITEMID.pickaxe_greenPickaxe: { mats[0] = ITEMID.item_copperOre; matsAmt[0] = 12; mats[1] = 9; matsAmt[1] = 5; itemAmt = 0; itemType = 2;} break;
    case ITEMID.pickaxe_stingerDrill: { mats[0] = ITEMID.item_copperOre; matsAmt[0] = 20; mats[1] = ITEMID.item_sweetComb; matsAmt[1] = 8; itemAmt = 0; itemType = 2;} break;
    case ITEMID.tile_copperTurret: { mats[0] = ITEMID.item_copperOre; matsAmt[0] = 15; mats[1] = 9; matsAmt[1] = 5; itemID = 12; itemAmt = 1; itemType = 3; } break;
    case ITEMID.tile_ladder: { mats[0] = 9; matsAmt[0] = 2; itemID = 13; itemAmt = 1; itemType = 3; } break;
    case ITEMID.cons_gremTalisman: { mats[0] = ITEMID.item_gremEssence; matsAmt[0] = 10; itemAmt = 1; itemType = 4; } break;
    case ITEMID.tile_platform: { mats[0] = 9; matsAmt[0] = 2; itemID = 16; itemAmt = 1; itemType = 3; } break;
    case ITEMID.cons_bomb: { mats[0] = 8; matsAmt[0] = ITEMID.item_copperOre; mats[1] = 15; matsAmt[1] = 2; mats[2] = ITEMID.item_copperOre; matsAmt[2] = 2; itemAmt = 1; itemType = 4; } break;
    case ITEMID.tile_packedStone: { mats[0] = 8; matsAmt[0] = 4; itemID = 18; itemAmt = 1; itemType = 3;} break;
    case ITEMID.tile_modBench: { mats[0] = ITEMID.item_gremEssence; matsAmt[0] = 30; mats[1] = ITEMID.item_copperOre; matsAmt[1] = 15; itemAmt = 1; itemType = 3;} break;
    case ITEMID.tile_woodenStilt: { mats[0] = ITEMID.item_stick; matsAmt[0] = 2; itemAmt = 2; itemType = 3;} break;
    case ITEMID.tile_battery: { mats[0] = ITEMID.item_copperOre; matsAmt[0] = 5; mats[1] = ITEMID.item_gremEssence; matsAmt[1] = 5; itemAmt = 1; itemType = 3;} break;
    case ITEMID.weapon_acornRifle: { mats[0] = ITEMID.item_copperOre; matsAmt[0] = 10; mats[1] = ITEMID.item_acorn; matsAmt[1] = 15; mats[2] = ITEMID.item_stick; matsAmt[2] = 100; itemAmt = 0; itemType = ITEMTYPE.weapon;} break;
    case ITEMID.weapon_beemerang: { mats[0] = ITEMID.item_copperOre; matsAmt[0] = 15; mats[1] = ITEMID.item_sweetComb; matsAmt[1] = 6; itemAmt = 0; itemType = ITEMTYPE.weapon;} break;
    case ITEMID.acc_beehiveBackpack: { mats[0] = ITEMID.acc_satchel; matsAmt[0] = -1; mats[1] = ITEMID.item_sweetComb; matsAmt[1] = 5; itemAmt = 0; itemType = ITEMTYPE.accessory;} break;
}

//Check the player's inventory.
var hc = hudControl;

for (i=0;i<maxInvenSlots;i++)
{ //Loop through inventory slots
    amt_remove[i] = 0;
    
    for (k=0;k<array_length_1d(mats);k++)
    {
        //Loop through each slot
        if hc.inventorySlotIcon[i] == mats[k] && hc.inventorySlotAmt[i] >= matsAmt[k] && mats[k] != 0
        {   
            amt_remove[i] = matsAmt[k];
            mats[k] = 0; //Set the material to "confirmed."
        }
    }
    
    //If the inventory has been searched 
    if i == maxInvenSlots-1
    { //Check for total confirmation
        for (k=0;k<array_length_1d(mats);k++) { if mats[k] != 0 then return false; } // The crafting has failed
        for (k=0;k<maxInvenSlots;k++) 
        { 
            if amt_remove[k] != 0 
            {
                scr_invenRemoveItem(0,amt_remove[k],0,false,k,noone); 
            }
        }
    }
} //Crafting succeeds if it makes it through the final check.

//Craft the item
scr_dropItem(itemID,itemAmt,itemType,obj_player.x,obj_player.y,noone);

return true;

