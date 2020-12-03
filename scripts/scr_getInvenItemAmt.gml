///scr_getInvenItemAmt(item);
//Returns an item's amount in the inventory.
var item = argument0;

for(i=0;i<maxInvenSlots;i++)
{
    if hudControl.inventorySlotIcon[i] == item
    {
        return hudControl.inventorySlotAmt[i];
    }
    
    //Fail case
    else if i == maxInvenSlots-1 then return -1;
}
