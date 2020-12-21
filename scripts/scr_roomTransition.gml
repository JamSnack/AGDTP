///scr_roomTransition(type,text,font,color,room);
if !instance_exists(efct_roomTransition)
{
    //Close menus
    
    with hudControl
    {
        
        //-Close other menus
        invOpen = false;
        showCraftingMenu = false;
        settingsMenu = false;
    }


    var i = instance_create(0,0,efct_roomTransition);
    var type = argument0;
    i.type = roomTransition_1;
    i.str = argument1;
    i.font = argument2;
    i.color = argument3;
    i.rm_goto = argument4;
    i.room_current = room;
}
