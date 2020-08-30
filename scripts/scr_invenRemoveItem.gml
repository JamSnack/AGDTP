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
        else if (slot == -1 && hudControl.inventorySlotTags[i] == tags && hudControl.inventorySlotIcon[i] == item)
        {
            if (hudAmt - invAmt) > 0 { hudControl.inventorySlotAmt[i] -= invAmt } else scr_clearSlot(i);
            if drop == true then scr_dropItem(item,invAmt,invType,obj_player.x+(20*obj_player.image_xscale),obj_player.y,tags);
            break;
        }
    }
} else if slot != -1
{
    var hudAmt = hudControl.inventorySlotAmt[slot]
    if invAmt == -1 then invAmt = hudAmt;
    
    if (hudAmt - invAmt) > 0 then hudControl.inventorySlotAmt[slot] -= invAmt else scr_clearSlot(slot); 
    if drop == true then scr_dropItem(item,invAmt,invType,obj_player.x,obj_player.y,tags);
    
}
