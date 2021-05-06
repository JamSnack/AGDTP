/// scr_findInvenItem(item)
//Returns the slot id of a given item..
var item = argument0;

for(i=0;i<maxInvenSlots;i++)
{
    if hudControl.inventorySlotIcon[i] == item
    {
        return i;
    }
    
    //Fail case
    else if i == maxInvenSlots-1 then return noone;
}
