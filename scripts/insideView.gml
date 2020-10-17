///insideView();
//Returns true if the instance is inside the view.
if point_in_rectangle(x-((sprite_width/2)*sign(((view_xview+view_wview)/2)-x)),y,view_xview,view_yview,view_xview+view_wview,view_yview+view_hview)
{
    return true;
} else return false;
