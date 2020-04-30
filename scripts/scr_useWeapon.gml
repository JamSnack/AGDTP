///scr_useWeapon(type,speed,friction,sprite,damage,knockAmt,projectileType);
var type = argument0;
var spd = argument1;
var frict = argument2;
var sprite = argument3;
var damage = argument4;
var knockAmt = argument5;

var proj = instance_create(x+8*image_xscale,y+lengthdir_y(2,point_direction(x,y,mouse_x,mouse_y)),obj_projectile);
proj.speed = spd;
proj.type = type;
proj.friction = frict;
proj.sprite_index = sprite;
proj.dmg = damage;
proj.direction = point_direction(proj.x,proj.y,mouse_x,mouse_y);
proj.image_angle = point_direction(proj.x,proj.y,mouse_x,mouse_y);
proj.knkAmt = knockAmt;
proj.ox = x;
proj.oy = y;

//Different types of projectiles get different stats
if type == 0 { proj.depth = -1; }
if type == 1 { proj.gravity = 0.05; proj.friction = 0;}
