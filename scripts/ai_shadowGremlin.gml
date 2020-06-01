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

if instance_exists(objective)
{ var canSeeObjective = !collision_line(x,y,objective.x,objective.y,OBSTA,true,false); } 

//Attack Check --------------------------------------------
if objective.canHurt == true
{
    if point_in_rectangle(objective.x,objective.y,x-atkBox,y-atkBox,x+atkBox,y+atkBox)
    {
        with objective  //Hurt the objective.
        {
            var dir = point_direction(x,y,other.x,other.y-2);
            scr_hurt(other.damage,HURT_LONG,true,6,dir);
        }
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

switch current_state
{    
    case MOVE:
    {
        //Direction
        var dir = sign(objective.x-x);
        var vdir = sign(objective.y-(y+16));
        
        //Horizontal Acceleration
        if dir == -1 //Objective is to the right
        { if hAccel > -maxAccel then hAccel -= accelRate; }
        else if dir == 1 { if hAccel < maxAccel then hAccel += accelRate; }
        
        //Vertical Acceleration
        if vdir == -1 //Objective is up
        { if vAccel > -maxAccel then vAccel -= accelRate; }
        else if vdir == 1 { if vAccel < maxAccel then vAccel += accelRate; }
        
        image_xscale = dir;
        
    }
    break;
    
    case WANDER:
    {
        if stateLock == false then state = MOVE;
    }
    break;
}


//------------------------------------------------------
//Collision and movement
var targetPlrTile = noone;

if !place_meeting(x+hAccel,y,OBSTA)
{ x += hAccel; }
else
{
    targetPlrTile = position_meeting(x+hAccel,y,OBSTA);
}

if !place_meeting(x,y+vAccel,OBSTA)
{ y += vAccel; }
else
{
    targetPlrTile = position_meeting(x,y+vAccel,OBSTA);
}

//Attack a tile.
if instance_exists(targetPlrTile)
{ 
    if object_is_ancestor(targetPlrTile,PLRTILE)
    { with targetPlrTile scr_hurt(other.damage,DEF_HURT,0,0,0); }
}

//Knockback Collision ---------------------------------------------
if ( hspeed != 0 || vspeed != 0 )
{
    if place_meeting(x+hspeed,y,OBSTA)
    {
        var dir = sign(hspeed);
        
        while !place_meeting(x+hspeed,y,OBSTA)
        { x+=dir; }
        hspeed = 0;
    }
    
    if place_meeting(x,y+vspeed,OBSTA)
    {
        var dir = sign(vspeed);
        
        while !place_meeting(x,y+vspeed,OBSTA)
        { y+=dir; }
    
        vspeed = 0;
    }
    
    if place_meeting(x,y+4,OBSTA)
    {
        var positivity = sign(hspeed);
    
        if positivity == 1
        {
            hspeed -= DEF_FRIC;
        } else if positivity == -1
        {
            hspeed += DEF_FRIC;
        }
        
        if abs(hspeed) < 1 then hspeed = 0;
    }
}
