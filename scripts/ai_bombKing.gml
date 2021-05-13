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
var bombRing = collision_circle(x,y,atkBox/2,PLRTILE,false,true);

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
            scr_hurt(d,HURT_LONG,true,8);
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
        
        image_xscale = dir*scale;
        
    }
    break;
    
    case WANDER:
    {
        //Bobbing animation
        var dir = sign(objective.x-x);
        image_xscale = dir*scale;
        
        bobAmt += bobRate*bobLinearDir;
        
        if bobDir == 1
        { 
            if bobAmt > 1 { bobDir = -1; }
            image_index = 1;
        }
        else
        if bobDir == -1
        { 
            if bobAmt < -1 { bobDir = 1; } 
            image_index = 0;
        }
        
        //bobLienarDirection
        if bobLinearDir != bobDir  { bobLinearDir = lerp(bobLinearDir,bobDir,0.1); }
    }
    break;
}

//Knockback Collision ---------------------------------------------
if ( hForce != 0 || vForce != 0 )
{
    var hdir = sign(hForce);
    var vdir = sign(vForce);

    if place_meeting_fast(hForce,0,OBSTA)
    {
        while !place_meeting_fast(hForce,0,OBSTA)
        { x+=hdir; }
        hAccel += hForce;
        hForce = 0;
    }
    
    if place_meeting_fast(0,vForce,OBSTA)
    {
        while !place_meeting_fast(0,vForce,OBSTA)
        { y+=vdir; }
    
        vAccel += vForce;
        vForce = 0;
    }
    
    x+=hForce;
    y+=vForce;
    
    vForce = approach(vForce,0,knock_resistance);
    hForce = approach(hForce,0,knock_resistance);
}

