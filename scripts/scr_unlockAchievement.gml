///scr_unlockAchievement(ACHIEVEMENT.id);
//This script handles simple achievement conditions, unlocks achievements, and grants some rewards.
var _ach = argument0;

if (achievements_unlocked[_ach] != 1)
{
    achievements_unlocked[_ach] = 1;
    
    //TODO: Make efct_achievement its own thing!
    var _d = scr_getAchievementInfo(_ach);
    
    //Notify player
    if instance_exists(obj_player)
    {
        var _inst = instance_create(0,0,efct_achievement);
        _inst.text = _d[0];
        
        audio_play_sound(snd_achievement_unlocked,20,false);
    }
    
    //Rewards
    var save = false;
    
    switch _ach
    {
        case ACHIEVEMENT.the_king_of_lesser_things: { turret_capacity_max += 1; save = true; } break;
        case ACHIEVEMENT.the_king_of_sky_and_sea: { turret_capacity_max += 1; save = true; } break;
        case ACHIEVEMENT.speedrunner_1: { turret_capacity_max += 1; save = true; } break;
        case ACHIEVEMENT.speedrunner_2: { turret_capacity_max += 1; save = true; } break;
        case ACHIEVEMENT.getting_dirty: { turret_capacity_max += 1; save = true; } break;
    }
    
    if save == true then scr_saveGame();
    
    //ACHIEVEMENT - The King of Everything
    //For very little optimal purposes, run this check only after we've collected the hardest achievement in the game.
    if (achievements_unlocked[ACHIEVEMENT.speedrunner_2] == 1)
    {
        for(ach_index=0;ach_index<ACHIEVEMENT.last;ach_index++)
        {
            if achievements_unlocked[ach_index] == ACHIEVEMENT.the_king_of_everything
            {
                scr_unlockAchievement(ACHIEVEMENT.the_king_of_everything);
            } 
            else if achievements_unlocked[ach_index] == 0 then break;
        }
    }
}
