///ai_gremlin(state,idle_sprite,move_sprite,speed,objective,attackBox);
var current_state = argument0;
var idle_sprite = argument1;
var move_sprite = argument2;
var spd = argument3;
var objective = argument4;
var atkBox = (argument5)/2;

var x_previous = round(xprevious);
var _x = round(x);

if instance_exists(objective)
{
    var xObjective = objective.x;
    var yObjective = objective.y;
    var canSeeObjective = !collision_line(x,y,objective.x,objective.y,OBSTA,true,false);


    //Attack Check --------------------------------------------
    if objective.canHurt == true
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
    }
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
            if vAccel > -maxAccel then vAccel -= accelRate; 
        }
        else if vdir == 1 
        { 
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
        //Bobbing animation        
        bobAmt += bobRate*bobLinearDir;
        
        if bobDir == 1
        { 
            if bobAmt > 1 { bobDir = -1; }
        }
        else
        if bobDir == -1
        { 
            if bobAmt < -1 { bobDir = 1; } 
        }
        
        //bobLienarDirection
        if bobLinearDir != bobDir  { bobLinearDir = lerp(bobLinearDir,bobDir,0.1); }
    }
    break;
    
}
