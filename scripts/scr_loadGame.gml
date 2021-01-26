///scr_loadGame();

//Check to see if the player has nothing in their inventory.
var empty = true;

for (i=0;i<maxInvenSlots;i++)
{
    if hudControl.inventorySlotIcon[i] != 0
    {
        empty = false;
        break;
    }
}

//Load the game
if (file_exists("agdtpSaveData.sav")) && empty == true
{
    var _wrapper = scr_loadJson("agdtpSaveData.sav");
    
    
    //---------------Load equipped accessories---------------
    
    var _list = _wrapper[? "ACC"];
    
    if _list != undefined
    {
        //Check to see if the accessory has already been equipped
        var list_size = ds_list_size(_list);
        
        for(_q=0;_q<list_size;_q++)
        {
            scr_applyAccessory(_list[| _q]);
        }
    }
    
    //Update inventory size if needed
    with hudControl
    {
    
        var array_size = array_length_1d(inventorySlotIcon);
        
        if maxInvenSlots > array_size
        {
            //- reinitialize the array
            inventorySlotIcon[maxInvenSlots-1] = 0;
            inventorySlotAmt[maxInvenSlots-1] = 0;
            inventorySlotType[maxInvenSlots-1] = 0;
            inventorySlotTags[maxInvenSlots-1] = noone; //Each slot has '2' tag slots.
            
            for (i=array_size;i<maxInvenSlots;i++)
            {
                inventorySlotIcon[i] = 0; //Nothing
                inventorySlotAmt[i] = 0; //No items
                inventorySlotType[i] = 0; //Default item. '1' for equippable tool.
                inventorySlotTags[i] = noone; //No tags
            }
        }
        else if maxInvenSlots < array_size
        {
            //If we lose slots, reallocate the affected items
            for(z=array_size-(array_size-maxInvenSlots);z<array_size;z++)
            {
                if inventorySlotIcon[z] != ITEMID.nil
                {
                    //Remove the item and re-add it to the inventory.
                    var _item = inventorySlotIcon[z];
                    var _amt = inventorySlotAmt[z]; 
                    var _type = inventorySlotType[z]; 
                    var _tags = inventorySlotTags[z];
        
                    //Unequip a removed accessory
                    if _type == ITEMTYPE.accessory
                    {
                        for(g=0;g<ds_list_size(accessories_equipped);g++)
                        {
                            if _item == accessories_equipped[| g]
                            {
                                scr_applyAccessory(_item);
                            }
                        }
                    }
                    
                    //Clear the slot
                    scr_clearSlot(z);
                    
                    //Reallocate the item
                    if scr_invenAddItem(_item,_amt,_type,_tags) == -1
                    {
                        scr_dropItem(_item,_amt,_type,obj_player.x,obj_player.y,_tags);
                    }
                }
            }
        }
    }
    
    
    //----------------Handle the inventory-------------
    
    //- load inventory slots
    var _list = _wrapper[? "INV"];
    
    //-The game file exists but contains nothing.
    if ds_list_size(_list) == 0
    {
        scr_invenAddItem(3,0,1,noone);
        scr_invenAddItem(4,0,2,noone);
        scr_hudMessage("Try not to misplace your items!",global.fnt_Ui,10,0,c_fuchsia,0);
    }
    
    for (var k=0;k<ds_list_size(_list);k++)
    {
        var _map = _list[| k];
        
        //Unpack inventory data
        var slot = _map[? "slot"];
        //loadedTags is a string  that contians an item's tags.
        var loadedTags = _map[? "tags"];
        var tags = ds_list_create();
        var newTag = ""; //Variable to hold a tag that will be built.
        
        
        if loadedTags != undefined
        {
        
            var split = "$"
            for(j=1;j<string_length(loadedTags)+1;j++)
            { 
                var str_copy = string_copy(loadedTags,j,1);

                if str_copy == split
                {
                    ds_list_add(tags,newTag);
                    newTag = "";
                } else
                {
                    newTag = newTag+str_copy;
                }
            }
        }
        
        scr_invenAddItem((_map[? "icon"]),real(_map[? "amt"]),real(_map[? "type"]),tags);
        ds_list_destroy(tags);
    }
    
    
    //---------------------Handle other data------------------------
    
    var _list = _wrapper[? "KING"];
    
    if _list != undefined
    {
        for (var k=0;k<ds_list_size(_list);k++)
        {
            kingDied_1 = _list[| 0];
        }
    }
    
    // - questline data
    var _list = _wrapper[? "QUEST"];
    
    if _list != undefined
    {
        mainQuest = _list[| 0];
        tip_controls = _list[| 1];
    }
    
    //- Player stat data
    var _list = _wrapper[? "STAT"];
    
    if _list != undefined
    {
        energyRegenRate = _list[| 0];
        energyMax = _list[| 1];
        tileRegenRate = _list[| 2];
        tileLevel = _list[| 3];
    }
    
    ds_map_destroy(_wrapper);
    print("Game Loaded");
} 
else if empty == true
{
    //Gift a fresh inventory.
    scr_invenAddItem(3,0,1,noone);
    scr_invenAddItem(4,0,2,noone);
}
