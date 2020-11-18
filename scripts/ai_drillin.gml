///ai_gremlin(state,idle_,jump_sprite,move_sprite,speed,objective,jumpSpeed,attackBox);
var current_state = argument0;
var idle_sprite = argument1;
var jump_sprite = argument2;
var move_sprite = argument3;
var spd = argument4;
var objective = argument5;
var jump_speed = argument6;
var atkBox = (argument7)/2;

var xObjective = objective.x;
var yObjective = objective.y;

var x_previous = round(xprevious);
var _x = round(x); 

//Attack Check --------------------------------------------
if objective.canHurt == true
{
    var nearestNoCol = instance_nearest(x,y,PLR_NOCOL);
    var _xx = x;
    var _yy = y;
    
    if point_in_rectangle(xObjective,yObjective,x-atkBox,y-atkBox+2,x+atkBox,y+atkBox+2)
    {
        with objective  //Hurt the objective.
        {
            scr_hurt(other.damage,HURT_LONG,true,6);
        }
        
        state = WANDER;
        stateLock = true;
        alarm[stateLockAlarm] = 30;
    } 
    else if instance_exists(PLR_NOCOL) && nearestNoCol.canHurt == true && state == MOVE && point_in_rectangle(nearestNoCol.x,nearestNoCol.y,x-atkBox,y-atkBox+2,x+atkBox,y+atkBox+2)
    {
        with nearestNoCol  //Hurt the objective.
        {
            scr_hurt(other.damage,HURT_LONG,true,6);
        }
    
        state = WANDER;
        stateLock = true;
        alarm[stateLockAlarm] = 30;
    }
}

//---------PIE CHECKS---------------
if target == obj_pie
{
    if x_previous = obj_pie.x //Do not stand on top of pie.
    {
        state = WANDER;
        stateLock = true;
        alarm[stateLockAlarm] = 60;
    }
}


//----------AI STATES--------------------------
if vspeed == 0 && hspeed == 0 //disable Ai states as long as knockback is being calculated
{
switch current_state
{    
    case MOVE:
    {
        //Direction
        //var variation; //How much the gremlin will vary horizontally (use sine waves);
        var dir = sign(objective.x-x);
        var vdir = sign(objective.y-y);
        var hAccelRate = accelRate/2;
        
        //Horizontal Acceleration
        if dir == -1 //Objective is to the right
        { if hAccel > -maxAccel then hAccel -= hAccelRate; }
        else if dir == 1 { if hAccel < maxAccel then hAccel += hAccelRate; }
        
        //Vertical Acceleration
        if vdir == -1 //Objective is up
        { if vAccel > -maxAccel then vAccel -= accelRate; }
        else if vdir == 1 { if vAccel < maxAccel then vAccel += accelRate; }
        
        x += hAccel;
        y += vAccel;
        
        if image_alpha != 0.4 then image_alpha = 0.4;
    }
    break;
    
    case WANDER:
    {
        
        x += hAccel;
        y += vAccel;
        if stateLock == false then state = MOVE;
    }
    break;
    
    case FALL:
    {
    
        if image_alpha != 1 then image_alpha = 1;
    
        //Fall towards the ground;
        var deAccelRate = 0.1;
        
        
        //-Horizontal
        if hAccel <= 1
        {
            //Slow hAcceleration to zero
            if hAccel > 0 then hAccel -= deAccelRate else if hAccel < 0 then hAccel += deAccelRate;
        }
        
        //-Vertical
        if vAccel <= maxAccelFall then
        { vAccel += accelRate; }
        
        //Move
        x += hAccel;
        y += vAccel;
    }
    break;
}
}

//Point directions
image_angle = point_direction(xBuffer,yBuffer,x,y);
