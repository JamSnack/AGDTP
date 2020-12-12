///scr_invenRemoveItem(item,amt,type,drop,slot,tags);

var item = argument0;
var invSlot;
var invAmt = argument1; //Type -1 to fully clear the item.
var invType = argument2; //Type of the item.
var drop = argument3; //Whether or not to spawn an instance of the item in the game world.
var slot = argument4; //Specific slot to drop. -1 if no specific item.
var tags = argument5; //The item's tags

//Get the item to add.
invSlot = item;

//Remove items from inventory
if item != ITEMID.nil
{
    for (i=0;i<maxInvenSlots;i++)
    {
        var hudAmt = hudControl.inventorySlotAmt[i];
        if invAmt == -1 then invAmt = hudAmt;
        
        //Check for existing item
        if slot == i
        {
            //Unequip a dropped accessory
            if invType == ITEMTYPE.accessory
            {
                for(g=0;g<ds_list_size(accessories_equipped);g++)
                {
                    if item == accessories_equipped[| g]
                    {
                        scr_applyAccessory(item);
                    }
                }
            }
            
            //Drop the item(s)
            if (hudAmt - invAmt) > 0 { hudControl.inventorySlotAmt[slot] -= invAmt } else scr_clearSlot(slot);
            if drop == true then scr_dropItem(item,invAmt,invType,obj_player.x+(20*obj_player.image_xscale),obj_player.y,tags);
            break;
        }
        else if (slot == -1 && hudControl.inventorySlotIcon[i] == item)
        {   
            //--TAG CONDITIONALS--
            var sameTags = false;
            var hudTags = hudControl.inventorySlotTags[i];
            
            //Initialize the tag size.
            var tagsSize = 0;
            
            if ds_exists(tags,ds_type_list)
            { tagsSize = ds_list_size(tags); }
            
            //Initialize the hud tags size.
            var hudSize = 0;
            
            if ds_exists(hudTags,ds_type_list) && hudTags != noone
            { hudSize = ds_list_size(hudTags); } else print("New item?");
            
            // 0 = 0 means we are removing an ingredient item with no previous tags.
            if tagsSize == hudSize
            {
                if tagsSize+hudSize == 0
                {
                    sameTags = true;
                }
                else
                {
                    //If they have the same size, then for each tag in tags, compare it to each tag in hudTags.
                    //If hudTags is passed without a match, then the tags are dissimilar.
                    for(_t=0;_t<tagsSize;_t++)
                    {
                        var current_tag = tags[| _t];
                        
                        for(_y=0;_y<hudSize;_y++)
                        {
                        
                            if current_tag == hudTags[| _y] 
                            {
                                if _t == tagsSize-1 then sameTags = true;
                                break;
                            }
                        }
                    }
                }
            }
            
            //------Here we actually drop the item.
            if sameTags == true
            {
                //Unequip a dropped accessory (again)
                if invType == ITEMTYPE.accessory
                {
                    for(g=0;g<ds_list_size(accessories_equipped);g++)
                    {
                        if item == accessories_equipped[| g]
                        {
                            scr_applyAccessory(item);
                        }
                    }
                }
                
                //-- drop the item (again)
                if (hudAmt - invAmt) > 0 { hudControl.inventorySlotAmt[i] -= invAmt } else { scr_clearSlot(i); }
                if drop == true then scr_dropItem(item,invAmt,invType,obj_player.x+(20*obj_player.image_xscale),obj_player.y,tags);
                break;
            }
        }
    }
} 
else if slot != -1
{
    //Unequip a dropped accessory (UNO MAS)
    if invType == ITEMTYPE.accessory
    {
        for(g=0;g<ds_list_size(accessories_equipped);g++)
        {
            if item == accessories_equipped[| g]
            {
                scr_applyAccessory(item);
            }
        }
    }
    
    //Y'know tha deal
    var hudAmt = hudControl.inventorySlotAmt[slot]
    if invAmt == -1 then invAmt = hudAmt;
    
    if (hudAmt - invAmt) > 0 then hudControl.inventorySlotAmt[slot] -= invAmt else scr_clearSlot(slot); 
    if drop == true then scr_dropItem(item,invAmt,invType,obj_player.x,obj_player.y,tags);
}
