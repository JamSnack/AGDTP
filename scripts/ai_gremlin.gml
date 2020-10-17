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

//Init platform
var platformCollide;

if (yObjective < y && point_distance(x,y,xObjective,y) < 16*5)
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
    var _xx = x;
    var _yy = y;
    
    if point_in_rectangle(xObjective,yObjective,x-atkBox,y-atkBox+2,x+atkBox,y+atkBox+2)
    {
        with objective  //Hurt the objective.
        {
            var dir = point_direction(x,y,_xx,_yy);
            scr_hurt(other.damage,HURT_LONG,true,3,dir);
        }
        
        state = WANDER;
        stateLock = true;
        alarm[stateLockAlarm] = 30;
    } 
    else if instance_exists(PLR_NOCOL) && state == MOVE && point_in_rectangle(nearestNoCol.x,nearestNoCol.y,x-atkBox,y-atkBox+2,x+atkBox,y+atkBox+2)
    {
        with nearestNoCol  //Hurt the objective.
        {
            var dir = point_direction(x,y,_xx,_yy-2);
            scr_hurt(other.damage,HURT_LONG,true,3,dir);
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
if (!position_meeting(x,y+16,OBSTA) || (!place_meeting(x,y+1,obj_platform) && platformCollide = true)) 
    && current_state != FALL
{
    if gremBlockCol == false || !position_meeting(x,y+16,GREM_BLOCK)
    { state = FALL; }
    
    if ceil(yObjective) > y && place_meeting(x,y+1,obj_platform)
    { platformCollide = false; state = FALL; }
}


//----------AI STATES--------------------------
//Direction
var dir = sign(xObjective-x);
var true_speed = (spd+hForce)*dir;

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
            if !place_meeting(x+true_speed,y,OBSTA) && !place_meeting(x+true_speed,y,GR_ENEMY)
            {
                if dir != 0 then image_xscale = dir;
            } else if vsp+vForce == 0 && !position_meeting(x+true_speed,y+jump_speed,OBSTA) {
                //Jump if there is a tile in front of the gremlin
                vsp = jump_speed;
            } else if place_meeting(x,y,GR_ENEMY)
            {
                //Use arbitrary values to decide which Gremlin moves.
                if instance_place(x,y,GR_ENEMY).id > id
                {
                    sprite_index = idle_sprite;
                } else state = WANDER;
            }
            
            x += (spd+hForce)*dir;
            
        }
        break;
        
        case WANDER:
        {
            if sprite_index != move_sprite then sprite_index = move_sprite;
            vForce = 0;
            
            if !canSeeObjective || stateLock == true
            {
                //Turn around at RAIDBOUNDS
                if interm == false
                {
                    if x < RAIDBOUND_Lower && gremBlockCol == false
                    {
                        image_xscale = 1;
                    } else if x > RAIDBOUND_Upper && gremBlockCol == false
                    {
                        image_xscale = -1;
                    }
                }
                
                
                //- Wander forward
                var hspd = (spd+hForce)*image_xscale;
                
                if !place_meeting(x+(hspd),y,OBSTA)
                {
                    if !place_meeting(x+(hspd),y,GR_ENEMY)
                    {
                        x += hspd;
                    } 
                    else if place_meeting(x,y,GR_ENEMY)
                    {
                        //Use arbitrary values to decide which Gremlin moves.
                        if instance_place(x,y,GR_ENEMY).id > id
                        {
                            sprite_index = idle_sprite;
                        } 
                        else x += hspd;
                    } else image_xscale = -image_xscale;
                }
                
                
                //- Jump Conditions -
                //- If tile in front or gap in front
                if vsp+vForce == 0 && 
                (
                    place_meeting(x+hspd,y,OBSTA) || 
                    !place_meeting(x+hspd,y+8,OBSTA) 
                )
                {
                    //Jump if it is possible else turn around.
                    if !place_meeting(x+hspd,y-16,OBSTA)
                    { vsp = jump_speed; } 
                    else image_xscale = -image_xscale;
                }
            } else state = MOVE;
        }
        break;
    }
    
    // Grem Block check ----------------------------
    if gremBlockCol == true
    {
        var flatLandsY = (room_height/2)-(16*3);
        
        if place_meeting(x,y,GREM_BLOCK)
        {
            while place_meeting(x,y,GREM_BLOCK)
            { y-=1; }
        }
        
    
        if position_meeting(x,flatLandsY,FLATLAND) || position_meeting(x,y-6,GREM_BLOCK) then gremBlockCol = false;
    }
    
    //Jump Check ------------------------------------------
    if (position_meeting(x,y+6,OBSTA) || position_meeting(x,y+6,obj_platform)) && current_state != FALL
    {
        if vsp+vForce == 0 && ((!position_meeting(x+2*(spd+hForce)*image_xscale,y+1,OBSTA) || _x == x_previous))
        {
            vsp = jump_speed;
            platformCollide = false;
        }
    }
    
    //Handle vertical movement states------------------------------------------
    if vsp+vForce != 0 || state = FALL
    {
        //Vertical Movement
        if vsp < maxGrav then vsp = vsp + grav;
        
        var hdir = sign(vsp+vForce); //up = -1, down = 1.
    
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
                    vForce = 0;
                }
            }
            
            if place_meeting(x,y+1,obj_platform) { vsp = 0; vForce = 0; }
        }
        
        //-------Gremlin Blocks
        if instance_exists(GREM_BLOCK) && gremBlockCol == true
        {
            if (place_meeting(x,y+vsp+vForce,GREM_BLOCK))
            {
                //move as close as we can
                while (!place_meeting(x,y+hdir,GREM_BLOCK))
                {
                    y = y + hdir;
                }
                vsp = 0;
                vForce = 0;
                state = WANDER;
                exit;
            }
        }
        
        //-----Normal Obstacles
        if (place_meeting(x,y+vsp+vForce,OBSTA))
        {
            //move as close as we can
            while (!place_meeting(x,y+hdir,OBSTA))
            {
                y = y + hdir;
            }
            vsp = 0;
            vForce = 0;
            state = WANDER;
            exit;
        }
        
        y = y + vsp+vForce;
        vForce = approach(vForce,0,2);
        
        var dir = image_xscale;
        
        //Move while in a vertical movement state.
        if !place_meeting(x+(spd*dir),y,OBSTA) then x += spd*dir;
        
        //Vertical sprites
        if sprite_index != jump_sprite then sprite_index = jump_sprite;
        
        if hdir == -1 then image_index = 0 else image_index = 1;
    }
}

//Knockback Collision ---------------------------------------------

if ( hForce != 0 || vForce != 0 )
{
    sprite_index = spr_gremlinJump;
    image_index = 1;

    //Separate gravity
    if vForce < maxGrav then vForce += grav;
    
    var hdir = sign(hForce);
    var vdir = sign(vForce);

    if place_meeting(x+hForce,y,OBSTA)
    {
        while !place_meeting(x+hForce,y,OBSTA)
        { x+=hdir; }
        hForce = 0;
    }
    
    if place_meeting(x,y+vForce,OBSTA)
    {
        while !place_meeting(x,y+vForce,OBSTA)
        { y+=vdir; }
    
        vForce = 0;
    }
    
    if place_meeting(x,y+4,OBSTA)
    {
       hForce = approach(hForce,0,knock_resistance);
    }
    
    x+=hForce;
    y+=vForce;
}
