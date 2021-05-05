///ai_gremlin(state,idle_sprite,jump_sprite,move_sprite,speed,objective,jumpSpeed,attackBox);
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
var xObjective = objective.x;
var yObjective = objective.y;

var spr_width = sprite_width;
var spr_height = sprite_height;

//Init platform
var platformCollide;
var on_platform = place_meeting(x,y+1,obj_platform);

if (yObjective < y-16 && point_distance(x,y,xObjective,y) < 16*5)
{ platformCollide = false }
else
platformCollide = true;

//----Despawn Check-----------
if position_meeting(x,y,OBSTA) then instance_destroy();

//Check for objective line of sight.
if instance_exists(objective)
{ var canSeeObjective = !collision_line(x,y,xObjective,yObjective,OBSTA,true,false); } 

//Attack Check --------------------------------------------
if objective.canHurt == true
{
    var nearestNoCol = instance_nearest(x,y,PLR_NOCOL);
    var nearestCol = instance_nearest(x,y,PLRTILE);
    var _xx = x;
    var _yy = y;
    
    if point_in_rectangle(xObjective,yObjective,x-atkBox,y-atkBox+2,x+atkBox,y+atkBox+2)
    {
        with objective  //Hurt the objective.
        {
            scr_hurt(other.damage,DEF_HURT,true,3);
        }
        
        state = WANDER;
        stateLock = true;
        alarm[stateLockAlarm] = 30;
    } 
    else if instance_exists(PLRTILE) && point_in_rectangle(nearestCol.x,nearestCol.y,x-atkBox,y-atkBox+2,x+atkBox,y+atkBox+2)
    {
        with nearestCol  //Hurt the objective.
        {
            scr_hurt(other.damage,HURT_LONG,true,3);
        }
    
        state = WANDER;
        stateLock = true;
        alarm[stateLockAlarm] = 30;
    }
    else if instance_exists(PLR_NOCOL) && state == MOVE && point_in_rectangle(nearestNoCol.x,nearestNoCol.y,x-atkBox,y-atkBox+2,x+atkBox,y+atkBox+2)
    {
        with nearestNoCol  //Hurt the objective.
        {
            scr_hurt(other.damage,HURT_LONG,true,3);
        }
    
        state = WANDER;
        stateLock = true;
        alarm[stateLockAlarm] = 30;
    }
}

//---------PIE CHECKS---------------
if x_previous = xObjective //Do not stand on top of pie.
{
    state = WANDER;
    stateLock = true;
    alarm[stateLockAlarm] = 40;
}

//Fall check---------------------------------------------
// -- platformCollide and not on a platform means potential fall conditions.
if (!position_meeting(x,y+16,OBSTA) || platformCollide == false && !on_platform)  && current_state != FALL
{
    if !instance_exists(GREM_BLOCK) || (instance_exists(GREM_BLOCK) && !position_meeting(x,y+16,GREM_BLOCK))
    { state = FALL; }
    
    else if ceil(yObjective) > y && on_platform
    { platformCollide = false; state = FALL; }
}


//----------AI STATES--------------------------
//Direction
var dir = sign(xObjective-x);

if vForce == 0 && hForce == 0 
//disable Ai states as long as knockback is being calculated to prevent stepping into a wall.
//Gremlins will also use their knockback momentum to move faster.
{
    switch current_state
    {
        case IDLE:
        {
            //The mob is idle
            if sprite_index != idle_sprite then sprite_index = idle_sprite;
            
            state = MOVE; //CHANGED FROM "if canSeeObject then state = MOVE;"
        }
        break;
        
        case MOVE:
        {
            if sprite_index != move_sprite then sprite_index = move_sprite;
            
            //Move
            var approach_speed = (spd+hForce)*image_xscale;
            hspd = approach(hspd,approach_speed,agility);
            var obsta_in_front = place_meeting(x+hspd,y,OBSTA);
            
            if hspd != 0 && !obsta_in_front
            {
                if dir != 0
                {
                    //Collision with an obstacle
                    if image_xscale != dir
                    {
                        hspd = 0;
                        image_xscale = dir;
                    }
                }
                
                x += hspd;
            }
            else if position_meeting(x+(((spr_width+1)/2)*image_xscale),y,obj_gremlin)
            {
                //Use arbitrary values to decide which Gremlin moves.
                var _gr = instance_place(x+(((spr_width+1)/2)*image_xscale),y,obj_gremlin);
                
                if instance_exists(_gr) && _gr.id > id
                {
                    sprite_index = idle_sprite;
                    hspd = 0;
                } else { state = WANDER; alarm[stateLockAlarm] = 5; stateLock = true; }
            }
            else if vsp == 0
            {
                //Jump
                vsp = jump_speed;
            }
        }
        break;
        
        case WANDER:
        {
            if sprite_index != move_sprite then sprite_index = move_sprite;
            
            if (!canSeeObjective || stateLock == true)
            {
                //Turn around at RAIDBOUNDS
                if interm == false && stateLock == false
                {
                    if x+hspd < RAIDBOUND_Lower
                    {
                        image_xscale = 1;
                        stateLock = true;
                        alarm[stateLockAlarm] = 30;
                    } else if x+hspd > RAIDBOUND_Upper
                    {
                        image_xscale = -1;
                        stateLock = true;
                        alarm[stateLockAlarm] = 30;
                    }
                }
                
                
                //- Wander forward
                //NOTE: the var, dir, is objective based. Wandering has no objective.
                //a "maximum speed to approach toward" is required for accurate collision checks. Use before flipping xscale, hspd tends to lag behind this value.
                var approach_speed = (spd)*image_xscale;
                hspd = approach(hspd,approach_speed,agility);
                var obsta_in_front = place_meeting(x+hspd,y,OBSTA);
                
                if hspd != 0 && !obsta_in_front
                {
                    x += hspd;
                }
                
                //- Jump Conditions -
                //- If tile in front or gap in front
                if (obsta_in_front || !place_meeting(x+hspd,y+8,OBSTA))
                {
                    //Jump if vsp = 0 else turn around.
                    if vsp == 0
                    { vsp = jump_speed; } 
                    else { image_xscale = -image_xscale; hspd = 0; }
                }
            } else state = MOVE;
        }
        break;
    }
    
    // Grem Block check ----------------------------
    if gremBlockCol == true && interm == false
    {
        var flatLandsY = (room_height/2)-(16*3);
        
        if position_meeting(x,y+spr_height,GREM_BLOCK)
        {
            while place_meeting(x,y,GREM_BLOCK)
            { y-=1; }
        }
        
    
        if position_meeting(x,y-6,GREM_BLOCK) then gremBlockCol = false;
    }
    
    //Handle vertical movement states------------------------------------------
    if vsp != 0 || state = FALL
    {
        //Vertical Movement
        if vsp < maxGrav then vsp = vsp + grav;
        
        var vdir = sign(vsp); //up = -1, down = 1.
    
        //--Platform Logic
        
        if platformCollide = true
        {
            var true_vsp = vsp+vForce;
            var colRect = collision_rectangle(x-4,y+true_vsp,x+4,y+15+true_vsp,obj_platform,true,true);
        
            if true_vsp > 0
            {     
                if colRect
                {
                    //Snap gremlin
                    // - value adjusted for platform center.
                    var platY = (colRect.y)-8
                    if y < platY && point_distance(x,y+16,x,platY) < 2 then y = (platY)-16;
                    
                    vsp = 0;
                }
            }
            
            if on_platform { vsp = 0; vForce = 0; }
        }
        
        //-------Gremlin Blocks
        if instance_exists(GREM_BLOCK) && gremBlockCol == true
        {
            if (place_meeting(x,y+vsp,GREM_BLOCK))
            {
                //move as close as we can
                while (!place_meeting(x,y+vdir,GREM_BLOCK))  && vsp != 0
                {
                    y = y + vdir;
                }
                vsp = 0;
                state = WANDER;
                
                exit;
            }
        }
        
        //-----Normal Obstacles
        if vsp != 0 && (place_meeting(x,y+vsp,OBSTA))
        {
            //move as close as we can
            while (!place_meeting(x,y+vdir,OBSTA))
            {
                y = y + vdir;
            }
            vsp = 0;
            state = MOVE;
            
            exit;
        }
        
        y = y + vsp;
        
        var dir = image_xscale;
        var approach_speed = ((spd)*dir);
        hspd = approach(hspd,approach_speed,agility/2);
        var obsta_in_front = place_meeting(x+hspd,y,OBSTA);
        
        //Move while in a vertical movement state.
       if hspd != 0 && obsta_in_front
       {
            if (hspd > 1 || hspd < -1)
            {
                while !place_meeting(x+sign(hspd),y,OBSTA)
                {
                    x+=sign(hspd);
                }
            }
            
            hspd = 0;
       } else x+=hspd;
        
        //Vertical sprites
        if sprite_index != jump_sprite then sprite_index = jump_sprite;
        
        if vdir == -1 then image_index = 0 else image_index = 1;
    }
    
    //Jump Check ------------------------------------------
    if vsp == 0 && (position_meeting(x,y+spr_height/2,OBSTA) || on_platform) && current_state != FALL
    {
        if ((!position_meeting(x+((spr_width/2)*(spd))*image_xscale,y+1,OBSTA) || _x == x_previous))
        {
            vsp = jump_speed;
            platformCollide = false;
        }
    }
}

//Knockback Collision ---------------------------------------------

else if ( hForce != 0 || vForce != 0 )
{
    hspd = 0;
    vsp = 0;
    
    sprite_index = jump_sprite;
    image_index = 1;

    //Separate gravity
    if vForce < maxGrav then vForce += grav;
    
    var hdir = sign(hForce);
    var vdir = sign(vForce);

    if place_meeting(x+hForce,y,OBSTA)
    {
        while hdir != 0 && !place_meeting(x+hdir,y,OBSTA)  
        { x+=hdir; }
        hForce = 0;
    }
    
    if place_meeting(x,y+vForce,OBSTA)
    {
        while !place_meeting(x,y+vdir,OBSTA)  && vdir != 0
        { y+=vdir; }
    
        vForce = 0;
    }
    
    if hForce == 0 && vForce == 0 then state = MOVE;
    
    x+=(hForce);
    y+=(vForce);
    
    if position_meeting(x,y+spr_height+1,OBSTA)
    {
       hForce = approach(hForce,0,knock_resistance);
    }
}
