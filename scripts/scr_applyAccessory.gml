/// scr_applyAccessory(accessory)
///scr_applyAccessory(accessory);
var equip = 0; //Whether to equip (1, add stats) or dequip (-1, decrease stats);
var slot_cost = 0;
var accessory = argument0;

//Check to see if the accessory has already been equipped
if !ds_exists(accessories_equipped,ds_type_list)
{
    globalvar accessories_equipped;
    accessories_equipped = ds_list_create();
    print("ERROR: accessories_equipped DS does not exist. Recreating.");
}

var list_size = ds_list_size(accessories_equipped);

for(_q=0;_q<list_size;_q++)
{
    if accessory == accessories_equipped[| _q]
    {
        //The accessory is equipped, de-equip it!
        equip = -1;
        break;
    } else equip = 1;
}

if list_size == 0 then equip = 1;

//Get the slot cost
if equip != 0
{
    slot_cost = scr_getSlotCost(accessory);
    
    //If can equip:
    //Check if slots are available
    //remove them
    //Else:
    //Return slot cost
    
    if equip == 1
    {
        //Do not equip please >:)
        if ds_exists(accessories_equipped,ds_type_list)
        {
            if ds_list_size(accessories_equipped) > 2
            {
                scr_hudMessage("Max accessories.",global.fnt_Ui,3,0,c_red,0);
                exit;
            }
        }
        
        //Calculate available slots
        var slots_available = 0;
        
        for(_q=0;_q<maxInvenSlots;_q++)
        {
            //If the slots are clear
            if hudControl.inventorySlotType[_q] == 0  && hudControl.inventorySlotAmt[_q] == 0 && hudControl.inventorySlotIcon[_q] == 0  && hudControl.inventorySlotTags[_q] == noone
            {
                //Don't need to check anything!
                if slot_cost == 0 { print("Zero cost"); break; }
                
                slots_available += 1;
            
                if slots_available == slot_cost
                {
                    //Slot_cost slots will be removed from the end of inventory.
                    //Remove items in the slots and re-add them to the inventory.
                    //This should always be possible because the amount of occupied slots does not change.
                    print("Z init: "+string(maxInvenSlots-slot_cost)+" | Cost: "+string(slot_cost));
                    for(z=maxInvenSlots-slot_cost;z<maxInvenSlots;z++)
                    {
                        if hudControl.inventorySlotIcon[z] != ITEMID.nil
                        {
                            //Remove the item and re-add it to the inventory.
                            var _item = hudControl.inventorySlotIcon[z];
                            var _amt = hudControl.inventorySlotAmt[z];
                            var _type = hudControl.inventorySlotType[z];
                            var _tags = hudControl.inventorySlotTags[z];
            
                            scr_clearSlot(z);
                            scr_invenAddItem(_item,_amt,_type,_tags);
                        }
                    }
                    
                    maxInvenSlots -= slot_cost;
                    break;
                }
            }
            
            //There are not enough available slots!
            if _q == maxInvenSlots-1 && slot_cost != 0
            {
                scr_hudMessage(string(slot_cost-slots_available)+ " more slot(s) required to equip accessory.",global.fnt_Ui,5,0,c_red,0);
                exit; 
                //Do not finish the script. The next part of the script will always equip or unequip something.
            } 
        }
    }
    
    //-------------------Equip or dequip--------------------
    scr_applyAccessoryStats(accessory,equip);
    
    //Add or remove the item from equipped_accessories;
    //NOTE: ds_lists automatically shrink or grow depending on whether or not you deleted an item or added one. No compression required!
    if equip == 1 
    { 
        ds_list_add(accessories_equipped,accessory);
        //Play equpped sound!
        scr_hudMessage("equipped!",global.fnt_Ui,5,accessory,c_green,0);
        audio_play_sound(snd_equip,8,false);
        
        //ACHIEVEMENT - Geared Up
        scr_unlockAchievement(ACHIEVEMENT.geared_up);
    }
    else if equip == -1 
    { 
        ds_list_delete(accessories_equipped,ds_list_find_index(accessories_equipped,accessory)); 
        //Play dequipped sound!
        maxInvenSlots += slot_cost;
        scr_hudMessage("un-equipped!",global.fnt_Ui,5,accessory,c_green,0);
        audio_play_sound(snd_unequip,8,false);
    }
}
