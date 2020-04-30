///ai_gremlin(state,idle_,jump_sprite,move_sprite,speed,objective,jumpSpeed,attackBox);
var current_state = argument0;
var idle_sprite = argument1;
var jump_sprite = argument2;
var move_sprite = argument3;
var spd = argument4;
var objective = argument5;
var jump_speed = argument6;
var atkBox = (argument7)/2;

var x_previous = round(xprevious);
var _x = round(x); 

//Attack Check --------------------------------------------
if objective.canHurt == true
{
    if point_in_rectangle(objective.x,objective.y,x-atkBox,y-atkBox,x+atkBox,y+atkBox)
    {
        with objective  //Hurt the objective.
        {
            var dir = point_direction(x,y,other.x,other.y-2);
            scr_hurt(other.damage,10,true,3,dir);
        }
        
        state = WANDER;
        stateLock = true;
        alarm[stateLockAlarm] = 50;
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
        
        //Horizontal Acceleration
        if dir == -1 //Objective is to the right
        { if hAccel > -maxAccel then hAccel -= accelRate; }
        else if dir == 1 { if hAccel < maxAccel then hAccel += accelRate; }
        
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
