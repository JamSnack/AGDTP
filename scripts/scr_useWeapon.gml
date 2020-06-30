///scr_useWeapon(type,speed,friction,sprite,damage,knockAmt,projectileType);
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


var proj = instance_create(x+8*image_xscale,y+lengthdir_y(2,point_direction(x,y,mouse_x,mouse_y)),obj_projectile);

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
    mask_index = spr_projectile1;
    
    
    
    //-Different types of projectiles get different stats
    if _type == 0 { depth = -1; }
    if _type == 1 { localGrav = 0.1; friction = 0;}
    
    
    
    
    //-APPLY TAG EFFECTS
    if ds_exists(tagsUnloaded,ds_type_list)
    {
        for (i=0;i<ds_list_size(tagsUnloaded);i++)
        {
            switch tagsUnloaded[| i]
            {
                //Increases projectile speed
                case "Fast": { speed += 3; } break;
                case "Burning": {sprite_index = spr_projectile2} break;
                case "OMG HAXX!!!": {sprite_index = spr_gremBlock; speed += 5; knkAmt += 20; dmg += 100; } break;
                case "Bouncy": { bBouncy = true; } break;
            }
        }
    }
}
