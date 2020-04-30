///scr_recipeGet(itemName)
var mats; // What type of material to look for
var matsAmt; // How much of the material to look for/consume.
var itemID; //The ID of the item to craft.
var amt_remove; //For material removing purposes.

switch argument0
{
    case "DULL_SWORD": { mats[0] = 1; matsAmt[0] = 2; itemID = 3; itemAmt = 0; itemType = 1;} break;
}

//Check the player's inventory.
var hc = hudControl;

for (i=0;i<maxInvenSlots;i++)
{ //Loop through inventory slots
    amt_remove[i] = 0;
    
    for (k=0;k<array_length_1d(mats);k++)
    {
        //Loop through each slot
        if hc.inventorySlotIcon[i] == mats[k] && hc.inventorySlotAmt[i] == matsAmt[k] && mats[k] != 0
        {   
            amt_remove[i] = matsAmt[k];
            mats[k] = 0; //Set the material to "confirmed."
        }
    }
    
    //If the inventory has been searched 
    if i == maxInvenSlots-1
    { //Check for total confirmation
        for (k=0;k<array_length_1d(mats);k++) { if mats[k] != 0 then return false; } // The crafting has failed
        for (k=0;k<maxInvenSlots;k++) { if amt_remove[k] != 0 then scr_invenRemoveItem(0,amt_remove[k],0,false,k); }
    }
} //Crafting succeeds if it makes it through the final check.

//Craft the item
scr_invenAddItem(itemID,itemAmt,itemType);


//Reset arrays

