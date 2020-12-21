///scr_useWeapon(type,speed,friction,sprite,damage,knockAmt);
var _type = argument0;
var spd = argument1;
var frict = argument2;
var sprite = argument3;
var damage = argument4;
var knockAmt = argument5;

//-------APPLY TAG EFFECTS-------------
/*--Tag Types--
    > "STAT"
        - Adjusts weapon/tool stats such as toolFireRate.
    > "PROJECTILE"
        - Adjusts projectile specific stats such as damage, projDecay, projSpeed, projType.
*/

var tagsUnloaded = hudControl.inventorySlotTags[hudControl.selectedSlot];




//--------------CREATE PROJECTILE------------------

    //Player's arm is 14 pixels long, travel this on the X and Y coordinates for proj origin.
    //SUM: Projectiles are created 14 pixels from x,y in the direction of the arm.
var proj = instance_create(x,y-6,obj_projectile);
var _armAngle = armAngle;
var _projDecay = projDecay;
var _toolFireRate = toolFireRate

with proj
{    
    //-Apply projectile statistics
    speed = spd;
    friction = frict;
    type = _type;
    sprite_index = sprite;
    dmg = damage;
    direction = point_direction(x,y,mouse_x,mouse_y);
    image_angle = direction;
    knkAmt = knockAmt;
    ox = x;
    oy = y;
    oSpeed = spd;
    tags = tagsUnloaded;
    
    
    
    //-Different types of projectiles get different stats
    if _type == 0 
    { 
        bStab = true; 
        armOffsetGoal = 20; //Standard offset goal
        armOffsetRate = _toolFireRate/(armOffsetGoal);
        alarm[2] = armOffsetRate*armOffsetGoal; 
        visible = dev;
    } else if _type == 1 { localGrav = 0.1; friction = 0;}
    else if _type == "SPHERE"
    {
        image_xscale = 0.125;
        image_yscale = 0.125;
        hAccel = hspeed;
        vAccel = vspeed;
        maxAccel = 8;
        accelRate = 0.3;
        speed = 0;
        
        alarm[2] = room_speed*5;
    }
    
    
    
    
    //-APPLY TAG EFFECTS
    if ds_exists(tagsUnloaded,ds_type_list)
    {
        for (i=0;i<ds_list_size(tagsUnloaded);i++)
        {
            switch tagsUnloaded[| i]
            {
                //Increases projectile speed
                case "Bouncy": { bBouncy = true; canBounce = true; } break;
                case "Hive": {bHive = true;} break;
            }
        }
    }
}
