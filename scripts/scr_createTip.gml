///scr_createTip(xscale,yscale,tipID);
var t_frame = 0;
var t_type = argument2;
var i = instance_create(x,y,obj_tip);

i.xscale = argument0;
i.yscale = argument1;

//Get the sprite frame from the tip ID
switch t_type
{
    case "controls": { t_frame = 0; } break;
    case "tools": { t_frame = 1; } break;
}

//- Update the tip frame value
i.tip_frame = t_frame;
i.tip_type = t_type;

