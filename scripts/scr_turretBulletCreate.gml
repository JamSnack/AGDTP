///scr_turretBulletCreate(x,y,target,speed,damage,object,sprite);
var xx = argument0;
var yy = argument1;
var target = argument2;

var i = instance_create(xx,yy,argument5);
i.direction = point_direction(xx,yy,target.x,target.y);
i.speed = argument3;
i.damage = argument4;
i.ox = xx;
i.oy = yy;
i.sprite_index = argument6;
