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
    switch _ach
    {
        case ACHIEVEMENT.the_king_of_lesser_things: { turret_capacity_max += 1; } break;
        case ACHIEVEMENT.the_king_of_sky_and_sea: { turret_capacity_max += 1; } break;
    }
}
