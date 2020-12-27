///scr_autoTile(tileID);
// GM efficient Auto-tile sprite script
// Original script by Taylor Lopez
// See the original script on Git Hub: https://github.com/iAmMortos/autotile

//MODIFIED FOR USE IN AGDTP :)

var tile = argument0;

with(tile)
{
    var img_height = sprite_height;
    var img_width = sprite_width;
    
    var u = 0;  // up
    var r = 0;  // right
    var d = 0;  // down
    var l = 0;  // left
    var ul = 0; // up-left
    var ur = 0; // up-right
    var dr = 0; // down-right
    var dl = 0; // down-left
    
    // Check adjacent side existence
    if (position_meeting(x,              y - img_height, OBSTA)) then u = 1;
    if (position_meeting(x + img_width,  y,              OBSTA)) then r = 2;
    if (position_meeting(x,              y + img_height, OBSTA)) then d = 4;
    if (position_meeting(x - img_width,  y,              OBSTA)) then l = 8;
    
    // Check corner existence
    if (position_meeting(x - img_height, y - img_width,  OBSTA)) then ul = 1;
    if (position_meeting(x + img_height, y - img_width,  OBSTA)) then ur = 2;
    if (position_meeting(x + img_height, y + img_width,  OBSTA)) then dr = 4;
    if (position_meeting(x - img_height, y + img_width,  OBSTA)) then dl = 8;
    
    var edges = u + r + d + l;
    var corners = 0;

    if (u && l) then corners += ul;
    if (u && r) then corners += ur;
    if (d && r) then corners += dr;
    if (d && l) then corners += dl;
    
    switch(edges)
    {
        case 0: image_index = 34; break; //0
        case 1: image_index = 23; break;
        case 2: image_index = 31; break;
        case 3:
            switch(corners)
            {
                case 0: image_index = 35; break; //3
                case 2: image_index = 20; break;
            }
        break;
        case 4: image_index = 3; break;
        case 5: image_index = 13; break;
        case 6:
            switch(corners)
            {
                case 0: image_index = 4; break;
                case 4: image_index = 0; break; //8
            }
        break;
        case 7:
            switch(corners)
            {
                case 0: image_index = 42; break;
                case 2: image_index = 14; break;
                case 4: image_index = 24; break;
                case 6: image_index = 10; break;
            }
        break;
        case 8: image_index = 33; break;
        case 9:
            switch(corners)
            {
                case 0: image_index = 38; break; //14
                case 1: image_index = 22; break;
            }
        break;
        case 10: image_index = 32; break;
        case 11:
            switch(corners)
            {
                case 0: image_index = 39; break;
                case 1: image_index = 36; break;
                case 2: image_index = 37; break; //19
                case 3: image_index = 21; break;
            }
        break;
        case 12:
            switch(corners)
            {
                case 0: image_index = 7; break;
                case 8: image_index = 2; break;
            }
        break;
        case 13:
            switch(corners)
            {
                case 0: image_index = 45; break;
                case 1: image_index = 17; break; //24
                case 8: image_index = 27; break;
                case 9: image_index = 12; break;
            }
        break;
        case 14:
            switch(corners)
            {
                case 0: image_index = 8; break; //27
                case 4: image_index = 6; break; //29
                case 8: image_index = 5; break; //28
                case 12: image_index = 1; break; //30
            }
        break;
        case 15:
            switch(corners)
            {
                case 0: image_index = 46; break; 
                case 1: image_index = 41; break;
                case 2: image_index = 40; break;
                case 3: image_index = 18; break; //34
                case 4: image_index = 29; break;
                case 5: image_index = 9; break;
                case 6: image_index = 44; break;
                case 7: image_index = 16; break;
                case 8: image_index = 30; break; //39
                case 9: image_index = 43; break;
                case 10: image_index = 19; break;
                case 11: image_index = 15; break;
                case 12: image_index = 28; break;
                case 13: image_index = 25; break; //44
                case 14: image_index = 26; break;
                case 15: image_index = 11; break; //46
            }
        break;
    }
}
