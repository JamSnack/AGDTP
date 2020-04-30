///scr_canPlace(obj);

//Check whether or not an object is placeable.
var col = argument0;


//Check for overlapping tiles.
var fact = cellSize/2;
var mX = round(mouse_x/(fact))*(fact);
var mY = round(mouse_y/(fact))*(fact);

for (i=0;i<array_length_1d(col);i++)
{
    if collision_rectangle(mX-fact,mY+fact,mX+fact,mY-fact,canPlaceList[i],false,false)
    {
        return true;
    }
}
