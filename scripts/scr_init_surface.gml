///scr_init_surface(surface,w,h);
//Creates the surface, sets the surface_target, and clears alpha.
var _sur = argument0;
var _w = argument1;
var _h = argument2;

_sur = surface_create(_w,_h);
surface_set_target(_sur);
draw_clear_alpha(c_white,0);
return _sur;
