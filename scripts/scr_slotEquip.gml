/// scr_slotEquip(slot)
///scr_slotEquip(slot);
//This script equips an item based on the type of item in the slot. For use in hudControl.
var slot = argument0;
var _tool = 0;
var _type = inventorySlotType[slot];
var _item = inventorySlotIcon[slot];

if _item != ITEMID.nil && obj_player.toolReady == true
{
    hudControl.selectedSlot = slot;
    obj_player.tool = _type;

    switch _type
    {
        case ITEMTYPE.weapon: { scr_applyWeaponStats(_item); } break;    
        case ITEMTYPE.pickaxe: { scr_applyPickaxeStats(_item); } break;
    }

    audio_play_sound(snd_inventoryClick,8,false);
} 
else 
{
    //If selected an empty slot, unselect it and exit the script.
    hudControl.selectedSlot = noone;
    exit;
}

//TAG RESETS
if bright_reset == true { obj_player.playerLight = 0; bright_reset = false; }

//-STATISTICAL TAG EFFECTS
var tagsUnloaded = hudControl.inventorySlotTags[hudControl.selectedSlot];

if ds_exists(tagsUnloaded,ds_type_list)
{
    for (_tag=0;_tag<ds_list_size(tagsUnloaded);_tag++)
    {
        var tag = tagsUnloaded[| _tag]
        
        //BRIGHT
        if tag == "Bright"
        {
            obj_player.playerLight += 16;
            bright_reset = true;
        }
    }
}
