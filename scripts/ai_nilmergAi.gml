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

if instance_exists(objective)
{ var canSeeObjective = !collision_line(x,y,objective.x,objective.y,OBSTA,true,false); } 

//Attack Check --------------------------------------------

if objective.canHurt == true
{
    var nearestNoCol = instance_nearest(x,y,PLR_NOCOL);
    var _xx = x;
    var _yy = y;
    
    if obj_player.canHurt == true && point_in_rectangle(obj_player.x,obj_player.y,x-atkBox,y-atkBox+2,x+atkBox,y+atkBox+2)
    {
        with obj_player  //Hurt the player.
        {
            scr_hurt(other.damage,HURT_LONG,true,4.5);
            
            if state == "DIVE" then state = "WANDER";
        }
    } 
    else if instance_exists(PLR_NOCOL) && point_in_rectangle(nearestNoCol.x,nearestNoCol.y,x-atkBox,y-atkBox+2,x+atkBox,y+atkBox+2)
    {
        with nearestNoCol  //Hurt the nearest tile.
        {
            scr_hurt(other.damage,HURT_LONG,true,4.5);
        }
    }
}


//----------AI STATES--------------------------

switch state
{    
    case "TRANSITION":
    {
        //Transition animation
        switch transition_to
        {
            case "DIVE":
            {
                if sprite_index != spr_nilmerg_transition
                {
                    sprite_index = spr_nilmerg_transition;
                    image_index = 4;
                }
            }
            break;
            
            case "WANDER":
            {
                if sprite_index != spr_nilmerg_transition
                {
                    sprite_index = spr_nilmerg_transition;
                    image_index = 0;
                    
                    wander_pointX = choose(RAIDBOUND_Upper,RAIDBOUND_Lower);
                }
            }
            break;
            
            case "HOVER":
            {
                if sprite_index != spr_nilmerg_transition
                {
                    sprite_index = spr_nilmerg_transition;
                    image_index = 0;
                }
            }
            break;
        }
    }
    break;
    
    case "DIVE":
    {
        sprite_index = spr_nilmerg_move;
        
        //Attack the living player!
        if obj_player.dead == false then objective = obj_player;
        
        //Direction
        var dir = sign(objective.x-x);
        var vdir = sign((objective.y-16)-y);
        
        //Horizontal Acceleration
        if dir == -1 //Objective is to the right
        { if hAccel > -maxAccel then hAccel -= accelRate; }
        else if dir == 1 { if hAccel < maxAccel then hAccel += accelRate; }
        
        //Vertical Acceleration
        vAccel = approach(vAccel,maxAccel*vdir,accelRate);
        
        image_xscale = dir*scale;
        
        x+=hAccel;
        y+=vAccel;
        
        if point_distance(xObjective,0,x_previous,0) <= 8
        {
            state = "TRANSITION";
            transition_to = "WANDER";
            objective = obj_pie;
        }
    }
    break;
    
    case "WANDER":
    {
        sprite_index = spr_nilmerg_hover;
        
        //Direction
        var dir = sign(wander_pointX-x);
        var vdir = sign(wander_pointY-y);
        
        //Horizontal Acceleration
        hAccel = approach(hAccel,maxAccel*dir,accelRate);
        
        //Vertical Acceleration
        vAccel = approach(vAccel,maxAccel*vdir,accelRate);
        
        image_xscale = dir*scale;
        
        //Slow down and stop at the target point!
        if point_distance(x,y,wander_pointX,wander_pointY) <= (vAccel+hAccel)*4
        {
            vAccel = approach(vAccel,0,accelRate*2);
            hAccel = approach(hAccel,0,accelRate*2);
        }
        
        x += hAccel;
        y += vAccel;
        
        if point_distance(x,y,wander_pointX,wander_pointY) <= 8 && (vAccel+hAccel) <= 1
        {
            state = "TRANSITION";
            transition_to = "HOVER";
        }
    }
    break;
    
    case "HOVER":
    {
        sprite_index = spr_nilmerg_hover;
        image_xscale = sign(objective.x-x)*scale;
        
        //Roll for an attack!
        var r = irandom(2);
        // 0 = stinger;
        // 1 = dive;
        // 2 = minion;
        
        if stateLock == false
        {
            switch r
            {
                case 0:
                {
                    //Shoot a stinger!
                    state = "TRANSITION";
                    transition_to = "DIVE";
                }
                break;
                
                case 1:
                {
                    //Attack the player!
                    var stinger = instance_create(x,y,obj_stinger);
                    var _dir = point_direction(x,y,obj_player.x,obj_player.y);
                    stinger.direction = _dir;
                    stinger.speed = 6;
                    stinger.dam = damage/2;
                    stinger.image_angle = _dir;
                }
                break;
                
                case 2:
                {
                    //Spawn a minion!
                    repeat(1+waveScale(1,20,0,2))
                    { instance_create(x,y,obj_beeMinion); }
                }
                break;
            }
        }
        //If 'r' did not change our state.
        if state != "TRANSITION" && stateLock == false
        {
            stateLock = true;
            alarm[stateLockAlarm] = clamp((attackCooldown*room_speed)*(hp/maxHp),60,attackCooldown*room_speed);
        }
    }
    break;
}


//------------------------------------------------------
//Collision and movement
//#region
var targetPlrTile = noone;
var _stall = 1;

if state == "DIVE" && tile_punch > 0
{
    if place_meeting_fast(hAccel,0,OBSTA)
    {
        targetPlrTile = collision_point(x+hAccel,y,PLRTILE,false,true);
    }
    
    if place_meeting_fast(0,vAccel,OBSTA)
    {
        targetPlrTile = collision_point(x,y+vAccel,PLRTILE,false,true);
    }
} 
else if tile_punch <= 0
{
    stateLock = true;
    alarm[stateLockAlarm] = _stall;
    state = "TRANSITION";
    transition_to = "WANDER";
    tile_punch = tile_punch_max;
}

//#endregion

//Attack a tile.
if state == "DIVE" && targetPlrTile != noone 
{ 
    var _damage = damage;
    if targetPlrTile.canHurt == true 
    {
        with targetPlrTile scr_hurt(_damage,DEF_HURT,false,0);
        
        tile_punch -= 1;
    }
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
