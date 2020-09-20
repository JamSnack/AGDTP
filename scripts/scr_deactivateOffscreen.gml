/// scr_deactivateOffscreen(inst)
///scr_deactivateOffscreen(inst);
var inst = argument0;
var outerBoundary = 15*16; //Slightly larger than the boundary used in activation. (15 tiles).

if instance_exists(inst)
{
    if !point_in_rectangle(inst.x,inst.y,view_xview[0]-outerBoundary,view_yview[0]-outerBoundary,view_xview[0]+viewWidth+outerBoundary,view_yview[0]+viewHeight+outerBoundary)
    {
        instance_deactivate_object(inst);
    }
}
