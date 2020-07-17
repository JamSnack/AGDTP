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
    if point_in_rectangle(xObjective,yObjective,x-atkBox,y-atkBox+2,x+atkBox,y+atkBox+2)
    {
        with objective  //Hurt the objective.
        {
            var dir = point_direction(x,y,other.x,other.y-2);
            scr_hurt(other.damage,HURT_LONG,true,6,dir);
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
if vspeed == 0 && hspeed == 0 //disable Ai states as long as knockback is being calculated to prevent stepping into a wall.
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
        
            //Direction
            var dir = sign(xObjective-x);
            
            //Move
            if !place_meeting(x+(spd*dir),y,OBSTA)
            {
                x += spd*dir;
                if dir != 0 then image_xscale = dir;
            } else if _x==x_previous && vsp == 0 {
                //Jump if there is a tile in front of the gremlin
                vsp = jump_speed;
            }
            
        }
        break;
        
        case WANDER:
        {
            if sprite_index != move_sprite then sprite_index = move_sprite;
            vspeed = 0;
            
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
                if !place_meeting(x+(spd*image_xscale),y,OBSTA)
                {
                    x += spd*image_xscale;
                }
                
                
                //- Jump Conditions -
                //- If tile in front or gap in front
                if vsp == 0 && 
                (
                    place_meeting(x+(spd*image_xscale),y,OBSTA) || 
                    !place_meeting(x+(spd*image_xscale),y+8,OBSTA) 
                )
                {
                    //Jump if it is possible else turn around.
                    if !place_meeting(x+(spd*image_xscale),y-16,OBSTA)
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
        if vsp == 0 && (!position_meeting(x+2*(spd*image_xscale),y+1,OBSTA) || _x == x_previous)
        {
            vsp = jump_speed;
            platformCollide = false;
        }
    }
    
    //Handle vertical movement states------------------------------------------
    if vsp != 0 || state = FALL
    {
        //Vertical Movement
        if vsp < maxGrav then vsp = vsp + grav;
        
        var hdir = sign(vsp); //up = -1, down = 1.
    
        //--Platform Logic
        
        if platformCollide = true
        {
            if vsp > 0
            {     
                if collision_rectangle(x-4,y+vsp,x+4,y+9+vsp,obj_platform,true,true)
                {
                    while (!collision_rectangle(x-4,y+hdir,x+4,y+10+hdir,obj_platform,true,true))
                    { 
                        if hdir != 1 || hdir != -1 then break;
                        y = y + hdir;
                    }
                    
                    //Snap gremlin to platform
                    // - value adjusted for platform center.
                    var platY = (instance_nearest(x,y+10,obj_platform).y)-8
                    if y < platY && point_distance(x,y+10,x,platY) < 2 then y = (platY)-9;
                    
                    vsp = 0;
                    state = WANDER;
                    exit;
                }
            }
        }
        
        //-------Gremlin Blocks
        if instance_exists(GREM_BLOCK) && gremBlockCol == true
        {
            if (place_meeting(x,y+vsp,GREM_BLOCK))
            {
                //move as close as we can
                while (!place_meeting(x,y+hdir,GREM_BLOCK))
                {
                    y = y + hdir;
                }
                vsp = 0;
                state = WANDER;
                exit;
            }
        }
        
        //-----Normal Obstacles
        if (place_meeting(x,y+vsp,OBSTA))
        {
            //move as close as we can
            while (!place_meeting(x,y+hdir,OBSTA))
            {
                y = y + hdir;
            }
            vsp = 0;
            state = WANDER;
            exit;
        }
        
        y = y + vsp;
        
        var dir = image_xscale;
        
        //Move while in a vertical movement state.
        if !place_meeting(x+(spd*dir),y,OBSTA) then x += spd*dir;
        
        //Vertical sprites
        if sprite_index != jump_sprite then sprite_index = jump_sprite;
        
        if hdir == -1 then image_index = 0 else image_index = 1;
    }
}

//Knockback Collision ---------------------------------------------
if ( hspeed != 0 || vspeed != 0 )
{
    sprite_index = spr_gremlinJump;
    image_index = 1;

    //Separate gravity
    if vspeed < maxGrav then vspeed += grav;

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
