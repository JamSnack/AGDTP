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
    var _list = _wrapper[? "INV"];
    
    for (var k=0;k<ds_list_size(_list);k++)
    {
        var _map = _list[| k];
        
        //Unpack inventory data
        var slot = _map[? "slot"];
        var tags = _map[? "tags"];
        
        if tags != undefined
        {
            print("TAGS: "+tags);
            //tags = json_decode(tags);
            print("Urethra Paradox: "+string(ds_exists(tags,ds_type_list)));
        }
        
        scr_invenAddItem(real(_map[? "icon"]),real(_map[? "amt"]),real(_map[? "type"]),tags);
    }
    ds_map_destroy(_wrapper);
    print("Game Loaded");
} else if empty == true
{
    scr_invenAddItem(3,0,1,noone);
    scr_invenAddItem(4,0,2,noone);
}
