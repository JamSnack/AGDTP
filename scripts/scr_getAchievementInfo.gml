///scr_getAchievementInfo(ACHIEVEMENT.name);
//Returns an array of information on an achievement.
var _d = array_create(2);
//[0] = name; [1] = description;

switch argument0
{
    case ACHIEVEMENT.getting_dirty: { _d[0] = "Getting Dirty"; _d[1] = "Collect a dirt clump."; } break;
    case ACHIEVEMENT.first_blood: { _d[0] = "First Blood"; _d[1] = "Kill something."; } break;

    default: 
    {
        _d[0] = "Null";
        _d[1] = "Achievement in the works!";
    }
}

return _d;
