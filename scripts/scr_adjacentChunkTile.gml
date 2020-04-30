///scr_adjacentChunkTile(chunkOwner,xx,yy);

var oldChunk = argument0;
var newChunk = -1;
var xx = argument1;
var yy = argument2;

//-Reassign ChunkOwner

//Check every adjacent block starting with the top left most block.
var tile_x,tile_y;

for (i=0;i<3;i++)
{
    switch i
    {
        case 0: {tile_x=0;tile_y=16;} break;
        case 1: {tile_x=0;tile_y=-16;} break;
        case 2: {tile_x=16;tile_y=0;} break;
        case 3: {tile_x=-16;tile_y=0;} break;
    }

    var col = collision_point(xx+tile_x,yy+tile_y,PLRTILE,true,true);
    
    if col
    {
        if col.chunkOwner != oldChunk { newChunk = col.chunkOwner; return newChunk; }
    }
}

return newChunk;

