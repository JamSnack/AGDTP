///scr_dropTag(tag,amount);
//Drop a tag!
var tag = string(argument0);
var list = ds_list_create();
ds_list_add(list,tag);

scr_dropItem(ITEMID.item_modTag,argument1,ITEMTYPE.def,x,y,list);
