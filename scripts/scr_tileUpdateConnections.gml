///scr_tileUpdateConnections(connection);
var connection = argument0;

    //Check every adjacent block starting with the top left most block.

var col_1 = collision_point(x,y-16,PLRTILE,false,false);
var col_2 = collision_point(x,y+16,PLRTILE,false,false);
var col_3 = collision_point(x-16,y,PLRTILE,false,false);
var col_4 = collision_point(x+16,y,PLRTILE,false,false);

if col_1
{ col_1.connectedTo = connection; }

if col_2
{ col_2.connectedTo = connection; }

if col_3
{ col_3.connectedTo = connection; }

if col_4
{ col_4.connectedTo = connection; }
