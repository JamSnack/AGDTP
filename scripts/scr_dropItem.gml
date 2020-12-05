///scr_dropItem(itemID,amt,type,x,y,tags);

/* item Types:
    0 - Resource/Default
    1 - Weapon
    2 - Pickaxe
    3 - Placeable Tile
    4 - Consumable Item
    5 - Accessory
*/

if argument0 != 0
{
    var item = instance_create(argument3,argument4,obj_itemDrop);
    item.image_index = argument0;
    item.amt = argument1;
    item.type = argument2;
    item.tags = argument5;
}

