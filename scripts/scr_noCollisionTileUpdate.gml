///scr_noCollisionTileUpdate(x, y);
var xx = argument0;
var yy = argument1;

if position_meeting(x,y,OBSTA) then instance_destroy();

for(i=0;i<9;i++)
{
    //Check every adjacent block starting with the top left most block.

    var column = floor(i/3);
    var col = collision_point(xx-16+(i*16)-(column*16*3),yy-16+(16*column),NOCOL,true,true); //Upper left most tile to begin with.
    
    if col
    {
        with col event_user(1);
    }
}
