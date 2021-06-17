///scr_invenAddItem(item,amt,type,tags);

var item = argument0;
var invSlot;
var invAmt = argument1; //A '0' is used to indicate whether or not an item is stackable.
var invType = argument2; // The type of the item. '0' Default. '1' Weapon. '2' Pickaxe. '3' placeable tile.
var invTags = argument3;

//Get the item to add.
invSlot = item;

//Add items to inventory
var newSlot = false;

if item != 0
{
    for (i=0;i<maxInvenSlots;i++)
    {
        var hudItem = hudControl.inventorySlotIcon[i];
        var hudTags = hudControl.inventorySlotTags[i];
        
        //-Note: the only stackable items that will have tags are modTags themselves. modTags will only ever contain one tag.
        var sameTags = false;
    
        if (ds_exists(invTags,ds_type_list) && ds_exists(hudTags,ds_type_list))
        {
            if invTags[| 0] == hudTags[| 0] then sameTags = true;
        } else sameTags = true;

        
        
        //-Check for the existing item
        if invSlot == hudItem && newSlot == false && hudControl.inventorySlotAmt[i] != 0 && sameTags = true
        { 
            hudControl.inventorySlotAmt[i] += invAmt;
            scr_hudMessage(" acquired",global.fnt_menu,3,invSlot,c_white,invAmt);
            
            return 2; 
        } 
        else if i == maxInvenSlots-1 && newSlot = false { i = 0; newSlot = true;}
        
        
        //Add item to new slot
        if newSlot == true && hudControl.inventorySlotIcon[i] == 0
        {
            //print("New slot");
            var _i = i;
            with hudControl
            {
                inventorySlotAmt[_i] = invAmt;
                inventorySlotIcon[_i] = invSlot;
                inventorySlotType[_i] = invType;
                
                if invTags != undefined
                {
                    if ds_exists(invTags,ds_type_list)
                    { 
                        //Create a new list specifically for the inv. slot to use instead of
                        // referencing a list that will be used again in the future.
                        // doing this should stop tag replication ;p
                        var invList = ds_list_create();
                        
                        for (_j=0;_j<ds_list_size(invTags);_j++)
                        {
                            ds_list_add(invList,invTags[| _j]);
                        }
                        
                        inventorySlotTags[_i] = invList;
                        ds_list_destroy(invTags);
                    }
                }
            }
            
            
            //RECIPE UNLOCKS
            scr_unlockRecipe(item);
            
            scr_hudMessage(" acquired",global.fnt_menu,3,invSlot,c_white,invAmt);
            return 1;
        }
    }
    return -1; //An item failed to enter the inventory.
}
