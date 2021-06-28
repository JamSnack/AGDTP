/// scr_findInvenItem(item)
//Returns the slot id of a given item..
var item = argument0;

for(inven_slot=0;inven_slot<maxInvenSlots;inven_slot++)
{
    if hudControl.inventorySlotIcon[inven_slot] == item
    {
        return inven_slot;
    }
    
    //Fail case
    else if inven_slot == maxInvenSlots-1 then return noone;
}
