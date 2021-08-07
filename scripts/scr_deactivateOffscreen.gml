/// scr_deactivateOffscreen(inst)
///scr_deactivateOffscreen(inst);
var inst = argument0;
var outerBoundary = 16*16; //(10 tiles).
var viewBuffer = 16*4;

if instance_exists(inst)
{
    inst.deactivate_method = "SCRIPT";

    //Deactivate offscreen
    if !point_in_rectangle(inst.x,inst.y,view_xview[0]-outerBoundary,view_yview[0]-outerBoundary,view_xview[0]+view_wview+outerBoundary,view_yview[0]+view_hview+outerBoundary)
    {
        instance_deactivate_object(inst);
    }
}
