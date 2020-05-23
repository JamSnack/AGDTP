///scr_loadGame();

//Check to see if the player has nothing in their inventory.
var empty = true;

for (i=0;i<maxInvenSlots;i++)
{
    if hudControl.inventorySlotIcon[i] != 0
    {
        print('gate');
        empty = false;
        break;
    }
}

if (file_exists("agdtpSaveData.sav")) && empty == true
{
    var _wrapper = scr_loadJson("agdtpSaveData.sav");
    var _list = _wrapper[? "ROOT"];
    
    for (var k=0;k<ds_list_size(_list);k++)
    {
        var _map = _list[| k];
        
        //Unpack inventory data
        var slot = _map[? "slot"];
        
        scr_invenAddItem(real(_map[? "icon"]),real(_map[? "amt"]),real(_map[? "type"]));
    }
    ds_map_destroy(_wrapper);
    print("Game Loaded");
} else if empty == true
{
    scr_invenAddItem(3,0,1);
    scr_invenAddItem(4,0,2);
}
