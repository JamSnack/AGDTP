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
    
    //use a local variable to thread the value through WITH's reference limitations
    var k_strength = knockback_strength;
    
    if obj_player.canHurt == true && point_in_rectangle(obj_player.x,obj_player.y,x-atkBox,y-atkBox+2,x+atkBox,y+atkBox+2)
    {
        with obj_player  //Hurt the player.
        {
            scr_hurt(other.damage,HURT_LONG,true,k_strength);
            
            if state == "DIVE" then state = "WANDER";
        }
    } 
    else if instance_exists(PLR_NOCOL) && point_in_rectangle(nearestNoCol.x,nearestNoCol.y,x-atkBox,y-atkBox+2,x+atkBox,y+atkBox+2)
    {
        with nearestNoCol  //Hurt the nearest tile.
        {
            scr_hurt(other.damage,HURT_LONG,true,k_strength);
        }
    }
}


//----------AI STATES--------------------------

switch state
{    
    case "DIVE":
    {
        var dive_maxAccel = (maxAccel*3)-((dive_time-60)/60);
        
        knockback_strength = 6;
        
        //Attack the living player!
        if obj_player.dead == false && insideView(x,y) then objective = obj_player;
        
        xObjective = objective.x;
        yObjective = objective.y;
        
        //--Move & animate.--
        if dive_time >= 60
        {
            target_image_index = 0;
            x+=hAccel;
            y+=vAccel;
            
            var drag = 0.18;
            
            hAccel = approach(hAccel,0,drag);
            vAccel = approach(vAccel,0,drag);
        }
        else
        {
            //Initialize the animation.
            image_speed = 0;
            target_image_index = 4;
            image_angle = approach(image_angle,point_direction(x,y,xObjective,yObjective)-90,10);
            
            //Direction
            var dir = sign(xObjective-x);
            var vdir = sign((yObjective-16)-y);
        
            //Horizontal Acceleration
            var len_dir = point_direction(x,y,xObjective,yObjective);
            
            if dir == -1 //Objective is to the right
            { hAccel = max(-dive_maxAccel,-lengthdir_x((xObjective-x),len_dir)); }
            else if dir == 1 {  hAccel = min(dive_maxAccel,lengthdir_x((xObjective-x),len_dir)); }
        
            //Vertical Acceleration
            vAccel = dive_maxAccel*vdir;
            
            if dive_time == 59
            {
                scr_playSound(snd_bliplo_prepare,false,12,x,y,1,true);
            }
        }
        
        //Transition back to WANDER
        if point_distance(xObjective,objective.y,x_previous,y) <= 8 || dive_time >= 180 || hAccel == 0
        {
            state = "WANDER";
            objective = obj_pie;
            dive_time = 0;
            target_image_index = 0;
            image_speed = animation_speed;
            wander_pointY = min(world_height-(12*16),scr_getHighestBasePoint()-(5*16));
        }
        
        dive_time += 1;
        
        //Animate
        image_index = approach(image_index,target_image_index,1);
    }
    break;
    
    case "WANDER":
    {
        knockback_strength = 4.5;
    
        //----ANIMATION-----
        //- Reset image angle
        if image_angle != 0 { image_angle = approach(image_angle,0,6); }
        image_speed = animation_speed;
        
        //----MOVEMENT-----
        //Direction
        var dir = sign(wander_pointX-x);
        var vdir = sign(wander_pointY-y);
        
        //Horizontal Acceleration
        hAccel = approach(hAccel,maxAccel*dir,accelRate);
        
        //Vertical Acceleration
        vAccel = approach(vAccel,maxAccel*vdir,accelRate);
        
        //Slow down and stop at the target point!
        if point_distance(x,y,wander_pointX,wander_pointY) <= (vAccel+hAccel)*4
        {
            vAccel = approach(vAccel,0,accelRate*2);
            hAccel = approach(hAccel,0,accelRate*2);
        }
        
        x += hAccel;
        y += vAccel;
        
        if point_distance(x,y,wander_pointX,wander_pointY) <= 8 && (vAccel+hAccel) <= 1 && image_angle == 0
        {
            state = "HOVER";
        }
    }
    break;
    
    case "HOVER":
    {
        knockback_strength = 4.5;
    
        //-----ANIMATION-------
        image_angle = 0;
        image_speed = animation_speed;
    
        //Roll for an attack!
        var r = irandom(2);
        // 0 = dive;
        // 1 = projectile;
        // 2 = minion summon;
        
        if stateLock == false
        {
            if last_move == r
            {
                r+=1;
                if r > 2 then r = 0;
            }
        
            switch r
            {
                case 0:
                {
                    //DIVE! GET HIM
                    state = "DIVE";
                    
                    if shield_charges < shield_charges_max
                    {
                        shield_charges += 1;
                        scr_playSound(snd_shield_deployed,false,8,x,y,1,true);
                    }
                }
                break;
                
                case 1:
                {
                    scr_playSound(snd_enemy_shoot,false,12,x,y,1,true);
                
                    //Projectile amounts
                    var hp_percent = hp/maxHp;
                    var proj_amt = 3;
                    
                    if hp_percent <= 0.20
                    {
                        proj_amt = 9;
                    }          
                    else if hp_percent <= 0.50
                    
                    {
                        proj_amt = 7;
                    }
                    else if hp_percent <= 0.75
                    {
                        proj_amt = 5;
                    }
                
                    //Spawn the attack
                    for(_proj=1;_proj<=proj_amt;_proj++)
                    {
                        var stinger = instance_create(x,y,obj_coralSpike);
                        var _dir = -(180/(proj_amt+1))*_proj;
                        stinger.direction = _dir;
                        stinger.speed = 5;
                        stinger.dam = damage/2;
                        stinger.image_angle = _dir;
                    }
                }
                break;
                
                case 2:
                {
                    scr_playSound(snd_bliplo_spawn,false,12,x,y,1,true);
                
                    //Spawn a minion!
                    repeat(1+waveScale(1,20,0,2))
                    { instance_create(x,y,obj_crabDrop); }
                }
                break;
            }
            
            last_move = r;
        }
        //If 'r' did not change our state.
        if state == "HOVER" && stateLock == false
        {
            stateLock = true;
            alarm[stateLockAlarm] = clamp((attackCooldown*room_speed)*(hp/maxHp),50,attackCooldown*room_speed);
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
    state = "WANDER";
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
