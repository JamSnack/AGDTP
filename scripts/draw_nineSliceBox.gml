///draw_nineSliceBox(sprite,x1,y1,x2,y2,subimage);
var size = sprite_get_width(argument0)/3;
var x1 = argument1;
var y1 = argument2;
var x2 = argument3;
var y2 = argument4;
var subimg = argument5;

var _w = x2-x1;
var _h = y2-y1;
var columns = _w div size;
var rows = _h div size;

//-corners
draw_sprite_part(argument0,subimg,0,0,size,size,x1,y1);
draw_sprite_part(argument0,subimg,size*2,0,size,size,x1+(columns*size),y1);
draw_sprite_part(argument0,subimg,0,size*2,size,size,x1,y1+(rows*size));
draw_sprite_part(argument0,subimg,size*2,size*2,size,size,x1+(columns*size),y1+(rows*size));

//-sides
for (i=1;i<rows;i++)
{
    draw_sprite_part(argument0,subimg,0,size,size,size,x1,y1+(+i*size));
    draw_sprite_part(argument0,subimg,size*2,size,size,size,x1+(columns*size),y1+(i*size))
}

for (i=1;i<columns;i++)
{
    draw_sprite_part(argument0,subimg,size,0,size,size,x1+(i*size),y1);
    draw_sprite_part(argument0,subimg,size,size*2,size,size,x1+(i*size),y1+(rows*size))
}

//-middle
for (i=1;i<columns;i++)
{
    for (k=1;k<rows;k++)
    {
        draw_sprite_part(argument0,subimg,size,size,size,size,x1+(i*size),y1+(k*size))
    }
}
