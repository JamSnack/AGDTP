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
if item != 0
{
    for (i=0;i<maxInvenSlots;i++)
    {
        var hudAmt = hudControl.inventorySlotAmt[i];
        if invAmt == -1 then invAmt = hudAmt;
        
        //Check for existing item
        if slot == i
        {
            if (hudAmt - invAmt) > 0 { hudControl.inventorySlotAmt[slot] -= invAmt } else scr_clearSlot(i);
            if drop == true then scr_dropItem(item,invAmt,invType,obj_player.x+(20*obj_player.image_xscale),obj_player.y,tags);
            break;
        }
        else if (slot == -1 && hudControl.inventorySlotIcon[i] == item)
        {
            var sameTags = false;
            var hudTags = hudControl.inventorySlotTags[i];
            
            if ds_exists(tags,ds_type_list)
            {
                var tagsSize = ds_list_size(tags);
                var hudSize = ds_list_size(hudTags);
                
                if tagsSize == hudSize
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
                                if _t=ds_list_size(tags)-1 then sameTags = true;
                                break;
                            }
                        }
                    }
                }
            }
            
            if sameTags == true
            {
                if (hudAmt - invAmt) > 0 { hudControl.inventorySlotAmt[i] -= invAmt } else scr_clearSlot(i);
                if drop == true then scr_dropItem(item,invAmt,invType,obj_player.x+(20*obj_player.image_xscale),obj_player.y,tags);
                break;
            }
        }
    }
} else if slot != -1
{
    var hudAmt = hudControl.inventorySlotAmt[slot]
    if invAmt == -1 then invAmt = hudAmt;
    
    if (hudAmt - invAmt) > 0 then hudControl.inventorySlotAmt[slot] -= invAmt else scr_clearSlot(slot); 
    if drop == true then scr_dropItem(item,invAmt,invType,obj_player.x,obj_player.y,tags);
    
}
