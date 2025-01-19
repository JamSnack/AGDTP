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

var on_ground = place_meeting_fast(0,1,OBSTA);
var knock_amt = knockAmt;

//Check for objective line of sight.
if instance_exists(objective)
{ var canSeeObjective = !collision_line(x,y,xObjective,yObjective,OBSTA,true,false); } 


//--Init platform--
var platformCollide; //Whether or not to collide with platforms at all.
var on_platform; //Whether or not the gremlin is on a platform.

if place_meeting_fast(0,1,obj_platform)
{
    if instance_nearest(x,y+1,obj_platform).y > y+spr_height/2
    {
        on_platform = true;
    }
    else on_platform = false;
} else on_platform = false;

if (yObjective > y && canSeeObjective)
{ platformCollide = false }
else
platformCollide = true;

//----Despawn Check-----------
if hForce == 0 && vForce == 0 && collision_point(x,y,OBSTA,false,true) then instance_destroy();

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
            scr_hurt(other.damage,DEF_HURT,true,knock_amt);
        }
        
        state = WANDER;
        stateLock = true;
        alarm[stateLockAlarm] = 30;
    } 
    else if instance_exists(PLRTILE) && point_in_rectangle(nearestCol.x,nearestCol.y,x-atkBox,y-atkBox+2,x+atkBox,y+atkBox+2)
    {
        with nearestCol  //Hurt the objective.
        {
            scr_hurt(other.damage,HURT_LONG,true,knock_amt);
        }
    
        state = WANDER;
        stateLock = true;
        alarm[stateLockAlarm] = 30;
    }
    else if instance_exists(PLR_NOCOL) && state == MOVE && point_in_rectangle(nearestNoCol.x,nearestNoCol.y,x-atkBox,y-atkBox+2,x+atkBox,y+atkBox+2)
    {
        with nearestNoCol  //Hurt the objective.
        {
            scr_hurt(other.damage,HURT_LONG,true,knock_amt);
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
// -- platformCollide = false and on a platform means we should fall through the platform.
//if current_state != FALL && (!place_meeting_fast(0,1,OBSTA) || platformCollide == false && on_platform)
if current_state != FALL && ((vForce == 0 && vsp == 0 && !on_ground) || platformCollide == false && on_platform)
{
    if on_platform && (yObjective > y+spr_height/2 && canSeeObjective)
    { platformCollide = false; state = FALL; }
    else if !on_platform
    {
        state = FALL;
    }
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
            var approach_speed = (spd)*image_xscale;
            hspd = approach(hspd,approach_speed,agility);
            var obsta_in_front = place_meeting_fast(hspd,0,OBSTA);
            
            //---Jump check--- if on ground || on platform and if there's a gap in the ground or a block in-front of us
            if (on_ground || on_platform) && (hspd != 0 && (!place_meeting_fast(8*sign(hspd),8,OBSTA) || obsta_in_front))
            {
                vsp = jump_speed;
            }
            
            
            //--- Movement and state logic ---
            if !obsta_in_front
            {
                if dir != 0
                {
                    //Turn around if objective position suddenly changes
                    if image_xscale != dir
                    {
                        hspd = 0;
                        image_xscale = dir;
                    }
                }
                
                x += hspd;
            }
            /*else if canSeeObjective
            {
                var _gr = collision_point(x+(((spr_width+1)/2)*image_xscale),y,obj_gremlin,false,true);
                
                if _gr != noone 
                {
                    //Slow down gremlins?
                    if instance_exists(_gr) && _gr.id > id
                    {
                        hspd = 0;
                    }
                }
            }*/
            else
            {
                state = WANDER; 
                alarm[stateLockAlarm] = 40; 
                stateLock = true;
                hspd = 0;
            }
        }
        break;
        
        case WANDER:
        {
            if sprite_index != move_sprite then sprite_index = move_sprite;
            
            if (!canSeeObjective || stateLock == true)
            {
                //Turn around at RAIDBOUNDS
                if interm == false && stateLock == false && (x > RAIDBOUND_Lower && x < RAIDBOUND_Upper) && y < stoneLayer-4*16
                {
                    if x+hspd < RAIDBOUND_Lower
                    {
                        image_xscale = scale;
                        stateLock = true;
                        alarm[stateLockAlarm] = 30;
                    } else if x+hspd > RAIDBOUND_Upper
                    {
                        image_xscale = -scale;
                        stateLock = true;
                        alarm[stateLockAlarm] = 30;
                    }
                }
                
                
                //-----Wander forward
                //NOTE: the local variable, dir, is objective based. Wandering has no objective.
                //a "maximum speed to approach toward" is required for accurate collision checks. Use before flipping xscale, hspd tends to lag behind this value.
                var approach_speed = (spd)*image_xscale;
                hspd = approach(hspd,approach_speed,agility);
                var obsta_in_front = place_meeting_fast(hspd,0,OBSTA);
                
                //--Jump Conditions
                //- If tile in front or gap in front
                if (on_ground || on_platform) && (hspd != 0 && (!place_meeting_fast(8*sign(hspd),8,OBSTA) || obsta_in_front))
                {
                    vsp = jump_speed;
                } else if obsta_in_front { image_xscale = -image_xscale; hspd = 0; }
                
                
                if !obsta_in_front
                {
                    x += hspd;
                }
            } else if canSeeObjective then state = MOVE;
        }
        break;
    }
    
    //Handle vertical movement states------------------------------------------
    if vsp != 0 || state = FALL
    {
        //Vertical Movement
        if vsp < maxGrav then vsp = vsp + grav;
        
        var vdir = sign(vsp); //up = -1, down = 1.
    
        //--------Platforms
        
        if platformCollide = true && vsp > 0
        {
            var true_vsp = vsp+vForce; //vForce is always 0 at this point but i'm too lazy to remove it here.
            var colRect = collision_line(x-4,y+spr_height/2+vsp,x+4,y+spr_height/2+vsp,obj_platform,false,true);
        
            if  colRect != noone && y+spr_height/2 < colRect.y
            {     
                //Snap gremlin
                // - value adjusted to simulate platform center on (8,0), not (8,8).
                var platY = (colRect.y)-8
               // if y < platY && point_distance(x,y+16,x,platY) < 4 then y = (platY)-1;
                
                vsp = 0;
            }
        }
        
        //-------Gremlin Blocks
        /*
        if instance_exists(GREM_BLOCK) && gremBlockCol == true && (place_meeting_fast(0,vsp,GREM_BLOCK))
        {
            //move as close as we can
            while (!place_meeting_fast(0,vdir,GREM_BLOCK))  && vsp != 0
            {
                y = y + vdir;
            }
            vsp = 0;
        }
        */
        //-----Normal Obstacles
        if (place_meeting_fast(0,vsp,OBSTA))
        {
            var vdir;
            
            if (vsp < 1 && vsp > -1) { vdir = vsp; }
            else vdir = sign(vsp);
        
            //move as close as we can
            while (!place_meeting_fast(0,vdir,OBSTA))
            {
                y = y + vdir;
            }
            vsp = 0;
        }

        y = y + vsp;
        
        var dir = image_xscale;
        var approach_speed = ((spd)*dir);
        hspd = approach(hspd,approach_speed,agility/2);
        var obsta_in_front = place_meeting_fast(hspd,0,OBSTA);
        
        //Move while in a vertical movement state.
       if obsta_in_front
       {
            var hdir = sign(hspd);
            
            if hspd < 1 && hspd > -1 && hspd != 0
            {
                hdir = hspd;
            }
        
            while !place_meeting_fast(hdir,0,OBSTA)
            {
                x+=hdir;
            }
       } else x+=hspd;
        
        //Vertical sprites
        if sprite_index != jump_sprite then sprite_index = jump_sprite;
        
        if vdir == -1 then image_index = 0 else image_index = 1;
        
        if vsp == 0 then state = WANDER;
    }
    
    //Jump Check ------------------------------------------
    /*if vsp == 0 && current_state != FALL && ((collision_point(x,y+1+spr_height/2,OBSTA,false,true) && collision_point(x+(spr_width/2),y,OBSTA,false,false)) || on_platform)
    {
        if ((!collision_point(x+((spr_width/2)*(spd))*image_xscale,y+1,OBSTA,true,false) || _x == x_previous))
        {
            vsp = jump_speed;
            platformCollide = false;
        }
    }*/
}

//Knockback Collision ---------------------------------------------

else
{
    //hspd = 0;
    //vsp = 0;
    
    sprite_index = jump_sprite;
    image_index = 1;

    //Separate gravity
    if vForce < maxGrav then vForce += grav;
    
    var hdir = sign(hForce);
    var vdir = sign(vForce);
    
    //Avoid crashing the game by checking for numbers less than 1 pixel
    if hForce < 1 && hForce > -1 && hForce != 0
    {
        hdir = hForce;
    }
    
    if vForce < 1 && vForce > -1 && vForce != 0
    {
        vdir = vForce;
    }

    if hdir != 0 && hForce != 0 && place_meeting_fast(hForce,0,OBSTA)
    {
        while !place_meeting_fast(hdir,0,OBSTA)  
        { x+=hdir; }
        hspd += hForce;
        hForce = 0;
    }
    
    if vdir != 0 && vForce != 0 && place_meeting_fast(0,vForce,OBSTA)
    {
        while !place_meeting_fast(0,vdir,OBSTA)
        { y+=vdir; }
    
        vForce = 0;
    }
    
    if hForce == 0 && vForce == 0 then state = MOVE;
    
    x+=(hForce);
    y+=(vForce);
    
    if collision_point(x,y+(spr_height/2)+1,OBSTA,false,true) != noone
    {
       hForce = approach(hForce,0,knock_resistance);
    }
}
