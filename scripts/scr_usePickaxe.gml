///scr_usePickaxe(pickDamage,pickLevel);
var pd = argument0;
var pl = argument1;

var xx = round(mouse_x/16)*16;
var yy = round(mouse_y/16)*16;

var col = collision_point(mouse_x,mouse_y,TILE,false,false);
var plr_col = collision_point(mouse_x,mouse_y,PLRTILE,false,false);
var no_col = collision_point(mouse_x,mouse_y,NOCOL,false,false);

if instance_exists(col)
{
    //Ensure the tile reachable.
    if distance_to_object(col) <= pickRange*16 && collision_line(x,y,col.x,col.y,col,false,false)
    {
    
        //Damage the tile
        if col.level <= pl then col.hp -= (pd-(pl/2));
        
        //Check for tile death otherwise heal.
        if col.hp <= 0 
        {
            var cx = col.x;
            var cy = col.y;
        
            with col { instance_destroy(); }
            scr_tileUpdate(cx,cy);
            
        } else col.alarm[0] = room_speed*5;
    }
}


//PLAYER TILES_---------------------------------
if instance_exists(plr_col)
{
    //Ensure the tile reachable.
    if distance_to_object(plr_col) <= pickRange*16 && collision_line(x,y,plr_col.x,plr_col.y,plr_col,false,false)
    {        
        //Damage the tile
        plr_col.hp -= plr_col.maxHp/2;
    
        //Check for tile death otherwise heal.
        if plr_col.hp <= 0
        {
            var cx = plr_col.x;
            var cy = plr_col.y;
        
            with plr_col { instance_destroy(); }
            scr_tileUpdate(cx,cy);
            scr_playerTileUpdate(cx,cy);
            
        } else plr_col.alarm[0] = room_speed*5;
    }
}

//-----------INTERACTABLES------------------
if instance_exists(no_col)
{
    //Ensure the tile reachable.
    if distance_to_object(no_col) <= pickRange*16 && collision_line(x,y,no_col.x,no_col.y,no_col,false,false)
    {
        //Damage the tile
        if no_col.level <= pl then no_col.hp -= (pd-(pl/2));
        
        //Check for tile death otherwise heal.
        if no_col.hp <= 0 
        {
            var cx = no_col.x;
            var cy = no_col.y;
        
            with no_col { instance_destroy(); }
            scr_tileUpdate(cx,cy);
            scr_noCollisionTileUpdate(cx,cy);
            
        } else no_col.alarm[0] = room_speed*5;
    }
}
