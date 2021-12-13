///scr_craftItem(itemName)
mats = 0; // What type of material to look for
matsAmt = 0; // How much of the material to look for/consume.
itemID = argument0; //The ID of the item to craft.
amt_remove = 0; //For material removing purposes.
cost = 0; // the essence cost of the material

//SET AMT OF ITEMS WITH AN AMT OF '0' TO '-1' IF USED AS A MATERIAL.
scr_getRecipe(itemID);

if currency_essence >= cost
{
    //Check the player's inventory.
    var hc = hudControl;

    //For each slot, we loop through and set amt_remove to 0. We also check to see if that slot is in our mats list. If it is, we flag that slot by setting its amt_remove to matsAmt.
    for (i=0;i<maxInvenSlots;i++)
    { 
        //Loop through inventory slots
        amt_remove[i] = 0;
        
        for (k=0;k<array_length_1d(mats);k++)
        {
            if mats[k] != 0 && hc.inventorySlotIcon[i] == mats[k] && hc.inventorySlotAmt[i] >= matsAmt[k]
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
                    //Note from about a year after writing this script: I have no idea why, but setting item to 0 is necessary for the crafting system to work.
                    var _type = hc.inventorySlotType[k];
                    var _pass = 0; //the value to pass into scr_invenRemoveItem.
                    
                    if _type == ITEMTYPE.accessory then _pass = hc.inventorySlotIcon[k];
                    
                    scr_invenRemoveItem(_pass,amt_remove[k],_type,false,k,noone); 
                    break;
                }
            }
        }
    } //Crafting succeeds if it makes it through the final check.
    
    //Craft the item
    scr_removeEssence(cost);
    scr_dropItem(itemID,itemAmt,itemType,obj_player.x,obj_player.y,noone);
    if audio_is_playing(snd_craftingSuccess)
    {
        audio_stop_sound(snd_craftingSuccess);
        audio_play_sound(snd_craftingSuccess,4,false);
        audio_sound_pitch(snd_craftingSuccess,choose(1,1.1,0.9));
    }
    else
    {
        audio_play_sound(snd_craftingSuccess,4,false);
        audio_sound_pitch(snd_craftingSuccess,choose(1,1.1,0.9));
    }
    
    //stat track
    global.items_crafted += 1;
    
    //Achievements - Crafting
    if global.items_crafted >= 250
        { scr_unlockAchievement(ACHIEVEMENT.handyman); }
    
    if itemType == ITEMTYPE.weapon
        { scr_unlockAchievement(ACHIEVEMENT.sharpened_blade); }
    else if itemType == ITEMTYPE.pickaxe
        { scr_unlockAchievement(ACHIEVEMENT.prepared_to_delve); }
    
    return true;
}

