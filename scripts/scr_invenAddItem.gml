///scr_invenAddItem(item,amt,type);

var item = argument0;
var invSlot;
var invAmt = argument1; //A '0' is used to indicate whether or not an item is stackable.
var invType = argument2; // The type of the item. '0' Default. '1' Weapon. '2' Pickaxe. '3' placeable tile.

//Get the item to add.
invSlot = item;

//Add items to inventory
var newSlot = false;

if item != 0
{
    for (i=0;i<maxInvenSlots;i++)
    {
        var hudItem = hudControl.inventorySlotIcon[i];
        
        //Check for existing item
        if invSlot == hudItem && newSlot == false && hudControl.inventorySlotAmt[i] != 0
        { 
            hudControl.inventorySlotAmt[i] += invAmt;
            scr_hudMessage(" acquired",global.fnt_menu,3,invSlot,c_white,invAmt);
            
            //Tutorial Quest
            if room == rm_zero
            {
                if tutorialComplete == false
                {
                    if currentTask == 0 //30 sticks
                    { if hudControl.inventorySlotIcon[i] == 9 && hudControl.inventorySlotAmt[i] >= 5 { currentTask = 1; }}
                    if currentTask == 3 //8 packed dirt
                    { if hudControl.inventorySlotIcon[i] == 6 && hudControl.inventorySlotAmt[i] >= 8 { currentTask = 4; }}
                    if currentTask == 4 //2 coppor ore
                    { if hudControl.inventorySlotIcon[i] == 10 && hudControl.inventorySlotAmt[i] >= 2 { currentTask = 5; }}
                }
            }
            
            return 2; 
        } 
        else if i == maxInvenSlots-1 && newSlot = false { i = 0; newSlot = true;}
        
        
        //Add item to new slot
        if newSlot == true && hudControl.inventorySlotIcon[i] == 0
        {
            print("New slot");
            hudControl.inventorySlotAmt[i] = invAmt;
            hudControl.inventorySlotIcon[i] = invSlot;
            hudControl.inventorySlotType[i] = invType;
            
            scr_hudMessage(" acquired",global.fnt_menu,3,invSlot,c_white,invAmt);
            return 1;
        }
    }
    return -1; //An item failed to enter the inventory.
}
