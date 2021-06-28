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

if instance_exists(objective)
{ var canSeeObjective = !collision_line(x,y,objective.x,objective.y,OBSTA,true,false); } 

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
            scr_hurt(other.damage,HURT_LONG,true,3);
        }
        
        state = WANDER;
        stateLock = true;
        if alarm[stateLockAlarm] == -1 then alarm[stateLockAlarm] = 30;
    } 
    else if instance_exists(PLR_NOCOL) && point_in_rectangle(nearestNoCol.x,nearestNoCol.y,x-atkBox,y-atkBox+2,x+atkBox,y+atkBox+2)
    {
        with nearestNoCol  //Hurt the objective.
        {
            scr_hurt(other.damage,HURT_LONG,true,3);
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
        
        image_xscale = dir*scale;
        
    }
    break;
    
    case WANDER:
    {
        if stateLock == false then state = MOVE;
        image_xscale = sign(hAccel)*scale;
    }
    break;
}

//-------------Conflate vForce and hForce for calculation---------------------
if vForce != 0 
{ 
    vForce = approach(vForce,0,knock_resistance);
}

if hForce != 0
{
    hForce = approach(hForce,0,knock_resistance);
}


//------------------------------------------------------
//Collision and movement
//#region
var targetPlrTile = noone;
var _stall = 1;

if !place_meeting_fast(hAccel+hForce,0,OBSTA)
{ x += hAccel+hForce; }
else if hForce == 0
{
    targetPlrTile = instance_place(x+hAccel,y,PLRTILE);
    
    stateLock = true;
    alarm[stateLockAlarm] = _stall;
    hAccel = -hAccel;
}

if !place_meeting_fast(0,vAccel+vForce,OBSTA)
{ y += vAccel+vForce; }
else if vForce == 0
{
    targetPlrTile = instance_place(x,y+vAccel,PLRTILE);
    
    stateLock = true;
    alarm[stateLockAlarm] = _stall;
    vAccel = -vAccel;
}

//#endregion

//Attack a tile.
if state != WANDER && targetPlrTile != noone 
{ 
    var _damage = damage;
    if targetPlrTile.canHurt == true then with targetPlrTile scr_hurt(_damage,DEF_HURT,false,0);
    
    state = WANDER;
    stateLock = true;
    alarm[stateLockAlarm] = 30;
}
