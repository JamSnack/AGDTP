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
    
    //------------Handle the inventory-----------
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
        
        scr_invenAddItem(real(_map[? "icon"]),real(_map[? "amt"]),real(_map[? "type"]),tags);
        ds_list_destroy(tags);
    }
    
    //-----------Handle other data------------------
    var _list = _wrapper[? "KING"];
    
    if _list != undefined
    {
        for (var k=0;k<ds_list_size(_list);k++)
        {
            kingDied_1 = _list[| 0];
        }
    }
    
    
    
    ds_map_destroy(_wrapper);
    print("Game Loaded");
} else if empty == true
{
    scr_invenAddItem(3,0,1,noone);
    scr_invenAddItem(4,0,2,noone);
}
