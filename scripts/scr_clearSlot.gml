/// scr_clearSlot(slot)

var slot = argument0;

with hudControl
{
    switch slot
    {
        case "all":
        {
            for(i=0;i<maxInvenSlots;i++)
            {
                inventorySlotIcon[i] = 0;
                inventorySlotAmt[i] = 0;
                inventorySlotTags[i] = noone;
                inventorySlotType[i] = 0;
            }
        }
        break;
        
        default:
        {
            inventorySlotIcon[slot] = 0;
            inventorySlotAmt[slot] = 0;
            inventorySlotTags[slot] = noone;
            inventorySlotType[slot] = 0;
        }
    }
}
