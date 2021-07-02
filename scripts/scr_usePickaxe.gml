///scr_usePickaxe(pickDamage,pickLevel);
var pd = argument0;
var pl = argument1;

var xx = round(mouse_x/16)*16;
var yy = round(mouse_y/16)*16;

var col = collision_point(mouse_x,mouse_y,TILE,false,false);
var plr_col = collision_point(mouse_x,mouse_y,PLRTILE,false,false);
var no_col = collision_point(mouse_x,mouse_y,NOCOL,false,false);

//TILES
if instance_exists(col)
{
    var hit_sound = col.hit_sound;
    
    //Ensure the tile reachable.
    if distance_to_object(col) <= pickRange*16 && collision_line(x,y,col.x,col.y,col,false,false)
    {
    
        //Damage the tile
        if col.level <= pl then col.hp -= (pd+(pl/2));
        
        //Check for tile death otherwise play sound & heal.
        if col.hp <= 0 
        {
            var cx = col.x;
            var cy = col.y;
        
            with col { instance_destroy(); }
            scr_tileUpdate(cx,cy);
            
        } 
        else 
        {
            //TILE Hit Sounds
            var _sound = snd_shield_deployed;
        
            switch hit_sound
            {
                case "DIRT": { _sound = choose(snd_dirtHit_1,snd_dirtHit_2,snd_dirtHit_3); } break;
                case "STONE": { _sound = choose(snd_stoneHit_1,snd_stoneHit_2,snd_stoneHit_3); } break;
            }
            
            audio_play_sound(_sound,8,false);
            
            //SET heal alarm
            col.alarm[0] = room_speed*5;
        }
    }
}


//PLAYER TILES_---------------------------------
if instance_exists(plr_col)
{
    //Ensure the tile reachable.
    if distance_to_object(plr_col) <= pickRange*16 && collision_line(x,y,plr_col.x,plr_col.y,plr_col,false,false)
    {        
        //Kill the player tile.
        var cx = plr_col.x;
        var cy = plr_col.y;
    
        with plr_col { instance_destroy(); }
        scr_tileUpdate(cx,cy);
    }
}

//-----------NO-COLLIDABLES------------------
if instance_exists(no_col)
{
    //Ensure the tile reachable.
    if no_col.canHit == true && distance_to_object(no_col) <= pickRange*16 && collision_line(x,y,no_col.x,no_col.y,no_col,false,false)
    {
        //Damage the tile
        if collision_point(mouse_x,mouse_y,PLR_NOCOL,false,false) then no_col.hp -= no_col.maxHp
        else if no_col.level <= pl then no_col.hp -= (pd-(pl/2));
        
        //Check for tile death otherwise heal.
        if no_col.hp <= 0 
        {
            var cx = no_col.x;
            var cy = no_col.y;
        
            with no_col { instance_destroy(); }
            scr_tileUpdate(cx,cy);
            
        } else no_col.alarm[0] = room_speed*5;
    }
}

//Create weak sword projectile
var proj = instance_create(x,y-6,obj_projectile);
var tf = toolFireRate;

with proj
{    
    //-Apply projectile statistics
    speed = tf;
    friction = 0;
    type = 0;
    sprite_index = hbox_swing;
    dmg = 1;
    direction = point_direction(x,0,mouse_x,0);
    image_angle = direction;
    knkAmt = 3;
    ox = x;
    oy = y;
    oSpeed = speed;
    bSwing = true;
    
    visible = dev;
}
