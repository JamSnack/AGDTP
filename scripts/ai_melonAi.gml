///ai_melonAi(state,speed,objective,jumpSpeed,attackBox);
var current_state = argument0;
var spd = argument1;
var objective = argument2;
var jump_speed = argument3;
var atkBox = (argument4)/2;

var xObjective = objective.x;
var yObjective = objective.y;
var direction_to_objective = point_direction(x,y,xObjective,yObjective);

var x_previous = round(xprevious);
var _x = round(x);

var player_in_sight = (instance_exists(obj_player) && distance_to_object(obj_player) < 16*7);

if instance_exists(objective)
{ var canSeeObjective = !collision_line(x,y,xObjective,yObjective,OBSTA,true,false); } 

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
//--- Search for resources: activating a chunk and looking for all its ores, finding the closest vein, deactivation, wander, collect, repeat.
//--- Retreat: If the player is nearby and the melon is not in growth 3, retreat to its base. If the player is in the melon's base, retreat to defend, or if enough essence to grow units.
//--- Grow: If at the origin point, spit out unit seeds.



switch state
{    
    case "DIG":
    {
        //Decide whether or not to depot..
        if ((player_in_sight) || (local_essence >= essence_needed_to_depot))
        {
            state = "DEPOT";
        }
        else
        {
            //Search for goodies to turn into essence!
            if instance_exists(obj_essenceOre)
            {
                objective = instance_nearest(x,y,obj_essenceOre);
            }
            else if instance_exists(obj_copperOre)
            {
                objective = instance_nearest(x,y,obj_copperOre);
            }
            else if instance_exists(obj_seashellMetal)
            {
                objective = instance_nearest(x,y,obj_seashellMetal);
            }
            else if instance_exists(GR_ENEMY)
            {
                objective = instance_nearest(x,y,GR_ENEMY);
            }
            else if instance_exists(TILE)
            {
                objective = instance_nearest(x+hAccel,y+vAccel,TILE);
            }
            //print(object_get_name(objective.object_index));
            //- update objective direction
            xObjective = objective.x;
            yObjective = objective.y;
            direction_to_objective = point_direction(x,y,xObjective,yObjective);
        }
        
        //Direction
        var dir = sign(xObjective-x);
        var vdir = sign(yObjective-y);
        
        //Horizontal Acceleration
        hAccel = approach(hAccel,maxAccel*dir,accelRate);
        
        //Vertical Acceleration
        vAccel = approach(vAccel,maxAccel*vdir,accelRate);
        
        _xscale = dir*scale;
        
        if !place_meeting_fast(hAccel,0,TILE) then x += hAccel;
        if !place_meeting_fast(0,vAccel,TILE) then y += vAccel;
        
        //--Hunt for Tiles to snack on
        if vine_delay <= 0 && (tile_grab = false ) && instance_exists(TILE) && (distance_to_nearest_object(TILE) <= sight)
        {
            vine_delay = vine_delay_set;
            tile_grab = true;
            
            //Eat the tile!
            var _tile = instance_nearest(x+lengthdir_x(16*4,direction_to_objective),y+lengthdir_y(16*4,direction_to_objective),TILE);
            
            if (_tile.object_index != TOTEM && _tile.object_index != obj_pie) && _tile
            {
                tile_grab_vine = scr_create_vine(x,y,_tile.x,_tile.y, true, 0, 12, _tile);
            }
        }
        else if !instance_exists(tile_grab_vine)
        {
            //Reset tile grabbing function
            tile_grab = false;
            tile_grab_vine = noone;
        }
    }
    break;
    
    case "DEPOT":
    {
        //Return to base and depot.
        //Direction
        var dir = sign(base_point_x-x);
        var vdir = sign(base_point_y-y);
        
        //Horizontal Acceleration
        hAccel = approach(hAccel,maxAccel*dir,accelRate);
        
        //Vertical Acceleration
        vAccel = approach(vAccel,maxAccel*vdir,accelRate);
        
        _xscale = dir*scale;
        
        //Drop stuff when we nearby the base_point
        if point_distance(x,y,base_point_x,base_point_y) <= 50
        {
            
            //Begin depositing essence for minions.
            if (!instance_exists(obj_builder_bloom) && local_essence > 25)
            {
                instance_create(x,y,obj_builder_bloom);
                local_essence -= 25;
            }
            else if (local_essence > 10)
            {
                instance_create(x,y,obj_spawn_seed);
                local_essence -= 10;
                //print("DROP");
            }
            else
            {
                state = "DIG";
            }
        }
        
        x += hAccel;
        y += vAccel;
        
        //Local_essence clamp
        local_essence = clamp(local_essence,0,essence_needed_to_depot*2);
    }
    break;
}

//----Vine Control----

//--Hunt for Gremlins to snack on
if (gremlin_grab = false ) && instance_exists(GR_ENEMY) && (distance_to_nearest_object(GR_ENEMY) <= sight)
{
    gremlin_grab = true;
    
    //Eat the gremlin!
    var _grem = instance_nearest(x,y,GR_ENEMY);
    
    gremlin_grab_vine = scr_create_vine(x,y,_grem.x,_grem.y, true, 0, 12, _grem);
}
else if !instance_exists(gremlin_grab_vine)
{
    //Reset gremlin grabbing function
    gremlin_grab = false;
    gremlin_grab_vine = noone;
}

//- Consume certain item drops
if instance_exists(obj_itemDrop) && distance_to_object(obj_itemDrop) <= 16*2
{
    var _it = instance_nearest(x,y,obj_itemDrop);
    var _value = 0;
    
    switch _it.image_index
    {
        case ITEMID.item_stick:
        case ITEMID.item_dirtClump:
        case ITEMID.item_stonePiece:
        { _value = 1; }
        break;
        
        case ITEMID.item_copperOre: 
        case ITEMID.item_seashellMetal:
        { _value = 5; } 
        break;
    }
    
    //Consume only those items of value
    if _value > 0
    {
        with _it
        {
            instance_destroy();
        }
        
        local_essence += _value;
    }
    
}

//-Animate
if (gremlin_grab == true || tile_grab == true)
{
    image_index = 1;
} else image_index = 0;

//- vine delay
if vine_delay > 0 then vine_delay -= 1;

//------------------------------------------------------
//Collision and movement
//#region
/*
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
*/

//#endregion

//Attack a tile.
/*
if state == "DIVE" && targetPlrTile != noone 
{ 
    var _damage = damage;
    if targetPlrTile.canHurt == true 
    {
        with targetPlrTile scr_hurt(_damage,DEF_HURT,false,0);
        
        tile_punch -= 1;
    }
}*/

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

//Animate
image_angle = approach(image_angle,point_direction(x,y,xObjective,yObjective),3);
