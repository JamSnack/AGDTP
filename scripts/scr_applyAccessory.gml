///scr_applyAccessory(accessory);
var equip = 0; //Whether to equip (1, add stats) or dequip (-1, decrease stats);
var slot_cost = 1;
var accessory = argument0;

//Check to see if the accessory has been equipped
var list_size = ds_list_size(accessories_equipped);

for(i=0;i<list_size;i++)
{
    if accessory == accessories_equipped[| i]
    {
        //The accessory is equipped, de-equip it!
        equip = -1;
    } else equip = 1;
}

if list_size == 0 then equip = 1;

//Get the slot cost
if equip != 0
{
    switch accessory
    {
        case ITEMID.acc_ultrablueStar: { slot_cost = 3; } break;
    }
    
    //If can equip:
    //Check if slots are available
    //remove them
    //Else:
    //Return slot cost
    
    if equip == 1
    {
        var slots_available = 0;
        for(i=0;i<maxInvenSlots;i++)
        {
            //If the slots are clear
            if hudControl.inventorySlotType[i] == 0  && hudControl.inventorySlotAmt[i] == 0 && hudControl.inventorySlotIcon[i] == 0  && hudControl.inventorySlotTags[i] == noone
            {
                slots_available += 1;
                
                if slots_available == slot_cost
                {
                    maxInvenSlots -= slot_cost;
                    break;
                }
            }
            
            //There are not enough available slots!
            if i == maxInvenSlots-1
            {
                scr_hudMessage(string(slot_cost-slots_available)+ " more slot(s) required to equip accessory.",global.fnt_Ui,5,0,c_red,0);
                exit; //Do not finish the script.
            }
        }
    }
    
    //-------------------Equip or dequip--------------------
    switch accessory
    {    
        case ITEMID.acc_ultrablueStar: { knock_resistance += 0.6*equip; } break;
    }
    
    //Add or remove the item from equipped_accessories;
    //NOTE: ds_lists automatically shrink or grow depending on whether or not you deleted an item or added one. No compression required!
    if equip == 1 
    { 
        ds_list_add(accessories_equipped,accessory);
        //Play equpped sound!
        scr_hudMessage("equipped!",global.fnt_Ui,5,accessory,c_green,0);
    }
    else if equip == -1 
    { 
        ds_list_delete(accessories_equipped,ds_list_find_index(accessories_equipped,accessory)); 
        //Play dequipped sound!
        maxInvenSlots += slot_cost;
        scr_hudMessage("un-equipped!",global.fnt_Ui,5,accessory,c_green,0);
    }
}
