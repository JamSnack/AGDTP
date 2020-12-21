///insideView(x,y);
//Returns true if the instance is inside the view.
if point_in_rectangle(argument0-((sprite_width/2)*sign(((view_xview+view_wview)/2)-argument0)),argument1,view_xview,view_yview,view_xview+view_wview,view_yview+view_hview)
{
    return true;
} else return false;
