/// scr_slotEquip(slot)
///scr_slotEquip(slot);
//This script equips an item based on the type of item in the slot. For use in hudControl.
var slot = argument0;
var _tool = 0;
var _type = inventorySlotType[slot];
var _item = inventorySlotIcon[slot];

if _item != ITEMID.nil && obj_player.toolReady == true
{
    switch _type
    {
        case 1:
            { //Weapon
            scr_applyWeaponStats(_item); _tool = 1;
            } break;
            
        case 2:
            { //Pickaxe
            scr_applyPickaxeStats(_item); _tool = 2;
            } break;
            
        case 3:
            { //Tile
            _tool = 3;
            } break;
        case 4:
            { //Consumable
            _tool = 4;
            } break;
    }
    
    obj_player.tool = _tool;
    scr_playSound(obj_player.localEmitter,snd_inventoryClick,false,8,obj_player.x,obj_player.y);
}

//TAG RESETS
if bright_reset == true { obj_player.playerLight = 16; bright_reset = false; }

//-STATISTICAL TAG EFFECTS
var tagsUnloaded = hudControl.inventorySlotTags[hudControl.selectedSlot];

if ds_exists(tagsUnloaded,ds_type_list)
{
    for (i=0;i<ds_list_size(tagsUnloaded);i++)
    {
        var tag = tagsUnloaded[| i]
        
        //BRIGHT
        if tag == "Bright"
        {
            obj_player.playerLight += 5;
            bright_reset = true;
        }
    }
}
