///scr_turretBulletCreate(x,y,target,speed,damage);
var xx = argument0;
var yy = argument1;
var target = argument2;

var i = instance_create(xx,yy,obj_turretBullet);
i.direction = point_direction(xx,yy,target.x,target.y);
i.speed = argument3;
i.damage = argument4;
i.ox = xx;
i.oy = yy;
