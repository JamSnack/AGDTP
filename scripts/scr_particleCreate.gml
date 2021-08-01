///scr_particleCreate(part_type,part_sprite);
//Used for creating collision particles.
var part_type = argument0;
var part_sprite = argument1;

switch part_type
{
    case "BLOOD":
    {
        if instance_number(part_gib) < 100 && !place_meeting_fast(0,0,OBSTA)
        {
            repeat(irandom_range(4,8))
            {
                var p = instance_create(x,y,part_gib);
                p.direction = irandom(180);
                p.speed = random_range(3,4);
                p.gravity = 0.20;
                p.gravity_direction = 270;
                p.alarm[0] = irandom_range(room_speed,room_speed*3);
                p.sprite_index = argument1;
                p.trail_part = _part_gib;
            }
        }
    }
    break;
}
