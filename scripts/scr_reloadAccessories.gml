///scr_reloadAccessories();

//Reset maxInvenSlots.
maxInvenSlots = hudControl.maxInvenSlots_original;


//This script refreshes slot cost and reapplies equipped accessories.
var _size = ds_list_size(accessories_equipped);
print("scr_reloadAccessories> size: "+string(_size));
if _size > 0
{
    for(i=0;i<_size;i++)
    {
        var accessory = accessories_equipped[| i];
        
        if accessory == 0
        {
            print("scr_reloadAccessories> Abort equip, accessory is 0. Remove this acc");
            ds_list_delete(accessories_equipped,i);
            continue;
        }
        
        //Apply the accessory's stats
        scr_applyAccessoryStats(accessory,1); 
        
        //Reallocates slot cost.
        //slot_cost = scr_getSlotCost(accessory);
        //maxInvenSlots -= slot_cost;
    }
}
