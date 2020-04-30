///scr_noCollisionTileUpdate(x, y, row, column, size);
var xx = argument0;
var yy = argument1;
var row = argument2; //The amount of tiles in a row
var col = argument3; //the amount of columns
var size = argument4; //Cell size

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
