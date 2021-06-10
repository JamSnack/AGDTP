///scr_craftItem(itemName)
mats = 0; // What type of material to look for
matsAmt = 0; // How much of the material to look for/consume.
itemID = argument0; //The ID of the item to craft.
amt_remove = 0; //For material removing purposes.

//SET AMT OF ITEMS WITH AN AMT OF '0' TO '-1' IF USED AS A MATERIAL.
scr_getRecipe(itemID);

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

