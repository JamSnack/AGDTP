///ai_bombKing(state,idle_,jump_sprite,move_sprite,speed,objective,jumpSpeed,attackBox);
var current_state = argument0;
var idle_sprite = argument1;
var jump_sprite = argument2;
var move_sprite = argument3;
var spd = argument4;
var objective = argument5;
var jump_speed = argument6;
var atkBox = (argument7)/2;

//Boss stuff.
var bombRing = collision_circle(x,y,atkBox*1.25,PLRTILE,false,true);

var x_previous = round(xprevious);
var _x = round(x);

if instance_exists(objective)
{ var canSeeObjective = !collision_line(x,y,objective.x,objective.y,OBSTA,true,false); } 

//Attack Check --------------------------------------------
if objective.canHurt == true && bombRing == noone
{
    if point_in_circle(objective.x,objective.y,x,y,atkBox)
    {
        var d = damage;
        var _x = x;
        var _y = y;
        
        with objective  //Hurt the objective.
        {
            var dir = point_direction(x,y,_x,_y);
            scr_hurt(d,HURT_LONG,true,8,dir);
        }
    }
} else if bombRing != noone
{
    state = WANDER;
    if alarm_get(3) == -1 then alarm[3] = room_speed;
}


//----------AI STATES--------------------------

switch current_state
{    
    case MOVE:
    {
        //Direction   
        var dir = sign(objective.x-x);
        var vdir = sign((objective.y-16)-y);
        
        //Horizontal Acceleration
        if dir == -1 //Objective is to the right
        { if hAccel > -maxAccel then hAccel -= accelRate; }
        else if dir == 1 { if hAccel < maxAccel then hAccel += accelRate; }
        
        //Vertical Acceleration
        if vdir == -1 //Objective is up
        {
            image_index = 0;
            if vAccel > -maxAccel then vAccel -= accelRate; 
        }
        else if vdir == 1 
        { 
            image_index = 1;
            if vAccel < maxAccel then vAccel += accelRate; 
        }
        
        x += hAccel;
        y += vAccel;
        
        image_xscale = dir;
        animRate = 0;
        animY = y;
        
    }
    break;
    
    case WANDER:
    {
        //Animate
        var dir = animDirection;
        
        
        if animRate > animRateMax*dir then animRate += animTrueRate
        else if animRate < animRateMax*dir then animRate -= animTrueRate;
        
        
        //Up
        if dir = 1
        {
            if y+animRate < animY-altitude then animDirection = -1;
        } 
        //Down
        else if dir = -1
        {
            if y+animRate > animY+altitude then animDirection = 1;
        }
        
        y += animRate;
    }
    break;
}

