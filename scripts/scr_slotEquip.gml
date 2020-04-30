///scr_slotEquip(slot);
//This script equips an item based on the type of item in the slot. For use in hudControl.
var slot = argument0;
var _tool = 0;

if obj_player.toolReady == true
{
    switch inventorySlotType[slot]
    {
        case 1:
            { //Weapon
            scr_applyWeaponStats(inventorySlotIcon[slot]); _tool = 1;
            } break;
            
        case 2:
            { //Pickaxe
            scr_applyPickaxeStats(inventorySlotIcon[slot]); _tool = 2;
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
}

