///ai_gremlin(state,speed,objective,jumpSpeed,attackBox);
var current_state = argument0;
var spd = argument1;
var objective = argument2;
var jump_speed = argument3;
var atkBox = (argument4)/2;

var xObjective = objective.x;
var yObjective = objective.y;

var x_previous = round(xprevious);
var _x = round(x); 

//Attack Check --------------------------------------------
var nearestNoCol = instance_nearest(x,y,PLR_NOCOL);
var nearestCol = instance_nearest(x,y,PLRTILE);
var _xx = x;
var _yy = y;

if objective.canHurt == true && point_in_rectangle(xObjective,yObjective,x-atkBox,y-atkBox+2,x+atkBox,y+atkBox+2)
{
    with objective  //Hurt the objective.
    {
        scr_hurt(other.damage,HURT_LONG,true,2);
    }
} 
else if instance_exists(PLR_NOCOL) && nearestNoCol.canHurt == true && point_in_rectangle(nearestNoCol.x,nearestNoCol.y,x-atkBox,y-atkBox+2,x+atkBox,y+atkBox+2)
{
    with nearestNoCol  //Hurt the objective.
    {
        scr_hurt(other.damage,HURT_LONG,true,2);
    }
}
else if instance_exists(PLRTILE) && point_in_rectangle(nearestCol.x,nearestCol.y,x-atkBox,y-atkBox+2,x+atkBox,y+atkBox+2)
{
    with nearestCol  //Hurt the objective.
    {
        scr_hurt(other.damage,HURT_LONG,true,3);
    }
}

//---------PIE CHECKS---------------
if target == obj_pie
{
    if x_previous = obj_pie.x //Do not stand on top of pie.
    {
        stateLock = true;
        alarm[stateLockAlarm] = 60;
    }
}


//----------AI STATES--------------------------
if vspeed == 0 && hspeed == 0 //disable Ai states as long as knockback is being calculated
{
    
    if current_state == FALL
    {
        var target_distance = point_distance(objective.x,0,x,0);
        var dir = sign(objective.x-x);
    
        if image_alpha != 1 then image_alpha = 1;
    
        //Fall towards the ground;
        var deAccelRate = 0.1;
        
        //If we're jumping and ascending, move toward the objective!
        if jumping == true && vAccel < 2
        {
            if dir == -1 //Objective is to the right
            { if hAccel > -maxAccel then hAccel -= accelRate*0.05; }
            else if dir == 1 { if hAccel < maxAccel then hAccel += accelRate*0.05; }
        }
        
        
        //-Horizontal damping
        if hAccel <= 1
        {
            //Slow hAcceleration to zero
            if hAccel > 0 then hAccel -= deAccelRate else if hAccel < 0 then hAccel += deAccelRate;
        }
        
        //-Vertical movement
        if vAccel <= maxAccelFall then
        { vAccel += 0.2; }
        
        //Reflect off of world boundaries
        if y+vAccel > room_height-8 then vAccel = -vAccel;
        if x+hAccel > room_width || x+hAccel < 0 then hAccel = -hAccel;
        
        //Vertical Collision
    
        
        //-------Attack BURST Logic--------
        if place_meeting_fast(0,vAccel,OBSTA)
        {
            //REAL COLLISION LOGIC!
            var vdir = sign(vAccel);
            
            while !place_meeting_fast(0,vAccel,OBSTA)
            { y+=vdir; }
            
            //-- When target is far away:
            var charge_goal = 3;
            
            if vAccel > 0 && !place_meeting_fast(0,jump_speed,OBSTA)
            {   
                //Control horizontal bursts and jump height!
                
                if target_distance > 16*4 && jump_charges == 0
                {
                    vAccel = jump_speed*2;
                    jump_charges = 0;
                
                    if dir == -1 //Objective is to the right
                    { if hAccel > -maxAccel then hAccel -= accelRate; }
                    else if dir == 1 { if hAccel < maxAccel then hAccel += accelRate; }
                }
            //-- When target is nearby:
                else
                {
                    //Begin charging our ULTRA JUMP!
                    vAccel = jump_speed+jump_charges*3;
                    
                    if jump_charges >= charge_goal
                    {
                        jump_charges = 0;
                        jumping = true;
                        vAccel = jump_speed*2;
                        
                        if dir == -1
                        { if hAccel > -maxAccel then hAccel -= accelRate/2; }
                        else if dir == 1 { if hAccel < maxAccel then hAccel += accelRate/2; }
                    }
                    
                    jump_charges += 1;
                }
            }
        }
        else
        {
            //Vertical move ( : ) :
            y += vAccel;
        }
        
        //Horizontal collision
        var hdir = sign(hAccel);
        if place_meeting_fast(hAccel,0,OBSTA)
        {
            while !place_meeting_fast(hAccel,0,OBSTA)
            { x+=hdir; }
            hAccel = -hAccel/3;
        }
        
        //Horizontal Move
        x += hAccel;
    }
}

//KNOCKBACK
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
    
    if y+vForce > room_height-8 then vForce = -vForce;
    if x+hForce > room_width || x+hForce < 0 then hForce = -hForce;
    
    x+=hForce;
    y+=vForce;
    
    vForce = approach(vForce,0,knock_resistance);
    hForce = approach(hForce,0,knock_resistance);
}

//Point directions
image_angle -= hAccel*2-vAccel*2;
