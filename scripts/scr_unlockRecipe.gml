///scr_unlockRecipe(item_id);
//Checks if a recipe can be unlocked and does it.
var notify_player = false;

switch argument0
{
    case ITEMID.item_copperOre: { if recipe_copperOre == false { recipe_copperOre = true; notify_player = true; } } break;
    case ITEMID.item_sweetComb: { if recipe_sweetComb == false { recipe_sweetComb = true; notify_player = true; } } break;
    case ITEMID.item_seashellMetal: { if recipe_seashellMetal == false { recipe_seashellMetal = true; notify_player = true; } } break;
}

if notify_player == true
{
    var c = make_colour_rgb(255,178,102);
    scr_overMessage("Recipes Unlocked",0,5,c);
    
    if instance_exists(obj_player)
    {
        audio_play_sound(snd_achievement_unlocked,20,false);
    }
}
