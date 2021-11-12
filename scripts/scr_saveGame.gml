///scr_saveGame();
var save_list = ds_list_create(); //Inventory data
var recipe_list = ds_list_create(); //Recipes unlocked
var quest_list = ds_list_create(); //List containing quest progress
var achieve_list = ds_list_create(); //List containing achievement bools
var stat_list = ds_list_create(); //List containing player stats to save.
var accessory_list = ds_list_create(); //List containing equipped accessories.
var settings_list = ds_list_create(); //List of settings to save.


//Save the inventory;
with hudControl
{
    
    for (i=0;i<maxInvenSlots;i++)
    {    
        if inventorySlotIcon[i] != 0
        {
            var _map = ds_map_create();
            ds_list_add(save_list,_map);
            ds_list_mark_as_map(save_list,ds_list_size(save_list)-1);
        
        
            //print('item saved '+string(inventorySlotIcon[i]));
            var icon = inventorySlotIcon[i];
            var type = inventorySlotType[i];
            var amt = inventorySlotAmt[i];
            var slot = i;
            
            //- Package item tags
            var tagList = inventorySlotTags[i];
            
            if ds_exists(tagList, ds_type_list)
            {
                var str = "";
                
                for (k=0;k<ds_list_size(tagList);k++)
                {
                    if is_string(str) && is_string(tagList[| k])
                    { str = str+tagList[| k]+"$"; }
                    else print("ERROR? TAG LIST: "+string(tagList[| k])+"| STR: "+string(str));
                }
                ds_map_add(_map,"tags",str);
            }
            
            
            //- Package item data
            ds_map_add(_map,"icon",icon);
            ds_map_add(_map,"type",type);
            ds_map_add(_map,"amt",amt);
            ds_map_add(_map,"slot",slot);
        }
    }
}

//Save other variables
ds_list_add(recipe_list,recipe_copperOre);
ds_list_add(recipe_list,recipe_sweetComb);
ds_list_add(recipe_list,recipe_seashellMetal);

ds_list_add(quest_list,mainQuest);
ds_list_add(quest_list,tip_controls);
ds_list_add(quest_list,tip_battery);
ds_list_add(quest_list,tip_shifting);

//- achievements
for(i=0;i<array_length_1d(achievements_unlocked);i++)
{
    ds_list_add(achieve_list,achievements_unlocked[i]);
}

ds_list_add(stat_list,currency_essence);
ds_list_add(stat_list,turret_capacity_max);
ds_list_add(stat_list,global.kills);
ds_list_add(stat_list,global.base_tiles_placed);
ds_list_add(stat_list,global.waves_survived);

//Save player stats
/*ds_list_add(stat_list,energyRegenRate);
ds_list_add(stat_list,energyMax);
ds_list_add(stat_list,tileRegenRate);
ds_list_add(stat_list,tileLevel);*/

//- Save equipped accessories
if ds_exists(accessories_equipped,ds_type_list)
{
    ds_list_copy(accessory_list,accessories_equipped);
}
//--Save settings--
//- save keybinds
ds_list_add(settings_list,global.key_jump);
ds_list_add(settings_list,global.key_left);
ds_list_add(settings_list,global.key_right);
ds_list_add(settings_list,global.key_down);
ds_list_add(settings_list,global.key_inven);
ds_list_add(settings_list,global.key_craft);
ds_list_add(settings_list,global.key_interact);
ds_list_add(settings_list,global.key_quick_heal);
ds_list_add(settings_list,global.key_1);
ds_list_add(settings_list,global.key_2);
ds_list_add(settings_list,global.key_3);
ds_list_add(settings_list,global.key_4);
ds_list_add(settings_list,global.key_5);
ds_list_add(settings_list,global.key_6);
ds_list_add(settings_list,global.key_7);

//- save other settings
ds_list_add(settings_list,music_volume);
ds_list_add(settings_list,vsyncToggled);




//Game maker prefers to start with a ds_map.
//Wrap the root List up in a map!
var _wrapper = ds_map_create();
ds_map_add_list(_wrapper,"INV",save_list);
ds_map_add_list(_wrapper,"RECIPE",recipe_list);
ds_map_add_list(_wrapper,"QUEST",quest_list);
ds_map_add_list(_wrapper,"ACHIEVE",achieve_list);
ds_map_add_list(_wrapper,"STAT",stat_list);
ds_map_add_list(_wrapper,"ACC",accessory_list);
ds_map_add_list(_wrapper,"SETTINGS",settings_list);

//Save to a string
var str = json_encode(_wrapper);
scr_saveString("agdtpSaveData.sav",str);

//"Nuke the data." ~Shuan Spalding
ds_map_destroy(_wrapper);

print('Game Saved');
