///scr_hurt(damage,time,knockback,knockAmt,direction);
var damage = argument0; //Damage dealt
var time = argument1; //Time until it can be hurt again.
var knock = argument2; //Whether or not to apply knockback.
var knockAmt = argument3; // How much knockback to be applied.
var dir = argument4; // Direction

 //knockback conditions
if object_get_parent(object_index) == TILE || object_get_parent(object_index) == PLRTILE  || object_get_parent(object_index) == PLT_1 || object_get_parent(object_index) == PLR_NOCOL
    { knock = false; damage = round(damage/10)+1 }

canHurt = false;
alarm[hurtAlarm] = time;
hp -= damage;

if knock == true
{
    knockBack = true;
    speed = -knockAmt;
    direction = dir;
    
    if knockType == "LAND"
    {
        if place_meeting(x+hspeed,y,OBSTA)
        {
            hspeed = 0;
        }
        
        if place_meeting(x,y+vspeed,OBSTA)
        {
            vspeed = 0;
        }
    }
}

//--Display pop message--
var c;
if object_index == obj_player then c = c_red else c = c_yellow;
scr_popMessage(string(damage),global.fnt_Ui,0.4,c,x,y);
