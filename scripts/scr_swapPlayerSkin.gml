///scr_swapPlayerSkin(skin_name);
var skin = argument0;

with obj_player
{
    switch skin
    {
        case "TAD":
        {
            sprite_jump = spr_tadJump;
            sprite_arm_jump = spr_arm_tadJump;
            sprite_walk = spr_tadWalk;
            sprite_arm_walk = spr_arm_tadWalk;
            sprite_idle = spr_tadIdle;
            sprite_arm_idle = spr_arm_tadIdle;
            sprite_arm_swing = spr_arm_tadSwing;
        }
        break;
        
        case "TIME":
        {
            sprite_jump = spr_timeGuyJump;
            sprite_arm_jump = spr_timeArmJump;
            sprite_walk = spr_timeGuyWalk;
            sprite_arm_walk = spr_nothing;
            sprite_idle = spr_timeGuyIdle;
            sprite_arm_idle = spr_nothing;
            sprite_arm_swing = spr_timeArmSwing;
        }
        break;
        
        default:
        {
            sprite_jump = spr_playerJump;
            sprite_arm_jump = spr_armJump;
            sprite_walk = spr_playerWalk;
            sprite_arm_walk = spr_armWalk;
            sprite_idle = spr_playerIdle;
            sprite_arm_idle = spr_armIdle;
            sprite_arm_swing = spr_armSwing;
        }
    }
}
