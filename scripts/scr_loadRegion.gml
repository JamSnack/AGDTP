/// scr_loadRegion(preset, region_type)
///scr_loadRegion(preset, terrain_type, ore, tree_bool);
//MODIFIED FOR USE IN REGION SHIFTING!

//----------GENERATE THE REGION VARIABLES----------------
randomize();
var preset = argument0, region_type = argument1;

/*-------- Presets:
-- "TUTORIAL"
*/


//Apply presets
if preset == "TUTORIAL"
{
    heightSeed = "554334567776554";
    heightNegativeSeed = "111111111000000111100";
}


//REGION SPECIFIC SETTINGS
var dirt_tileset = obj_dirt;
var stone_tileset = obj_stone;
var tree_bool = true;
var spawner_bool = false;
var spawner_type = obj_hiveGrowth;

var background_far = bkg_overworld_ocean;
var background_close = bkg_overworldHills_new;
var foreground = bkg_overworldGrass;
var background_cave = bkg_cave;

var ore_type = obj_copperOre;
var totem_type = obj_hiveTotem;


switch region_type
{
    case "GRASSLANDS":
    {
        if wave != 0 then spawner_bool = true;
    }
    break;
    
    case "COVE":
    {
        dirt_tileset = obj_sand;
        stone_tileset = obj_sandStone;
        tree_bool = false;
        ore_type = obj_seashellMetal;
        totem_type = obj_squidTotem;
        
        background_far = bkg_overworld_ocean;
        background_close = bkg_dunesOG_new;
        foreground = bkg_sand_foreground;
        background_cave = bkg_cave;
        
        heightSeed = get_height_seed(35,"HILL", 8, 12,3);
        heightNegativeSeed = "111111111000000111100";
    }
    break;
}

//Init some variables I guess :)
var _flatX = 32;
var _flatY = 5;
var flatLandTotal = _flatX*_flatY;

var sizeX = 64; //64x30 target world size. Repeated on the other side of the flat lands.
var sizeY = 60;

//Total amount of positions to iterate through.
var worldLandTotal = ((sizeX*sizeY)*2)+flatLandTotal;

//------CLOCK---------

if time == 1
{
    if instance_exists(NOCOL) 
    { 
        with NOCOL 
        { 
            if !(x > RAIDBOUND_Lower && x < RAIDBOUND_Upper && y < stoneLayer-48) 
            { 
                itemDrop = false;
                instance_destroy();
            }
        }
    }

    if instance_exists(TILE) then with TILE { if object_index != obj_pie then instance_destroy(); }
}

else if time == 2
{
    if instance_exists(PLRTILE)
    { 
        with PLRTILE 
        {
            if !(x > RAIDBOUND_Lower && x < RAIDBOUND_Upper && y < stoneLayer-48) 
            { 
                itemDrop = false;
                instance_destroy(); 
            } 
        }
    }
    
    if instance_exists(obj_nullLight) then with obj_nullLight { instance_destroy(); }
}

else if time == 3
{
    //Extra cleanup
    if instance_exists(obj_itemDrop) 
    {
        with obj_itemDrop 
        { 
            if !(x > RAIDBOUND_Lower && x < RAIDBOUND_Upper && y < stoneLayer-48) 
            {    
                instance_destroy(); 
            }
        }
    }
}

else if (time >= 4 && time <= 43 )
{        
    //Dirt and Stone layer
    for(i=4*(time-4);i<4*(time-3);i++)
    {   
        var xInterval = (xx+(i*16)); //The x coordinate
        var c = floor(i/string_length(heightSeed));
        var heightIndex = real(string_char_at(heightSeed,(i-(c*string_length(heightSeed)))))*16;
        var heightDirection = real(string_char_at(heightNegativeSeed,(i-(c*string_length(heightNegativeSeed)))));
        
        //Interpret heightNegativity
        // - Figure out whether or not to negate the number.
        if heightDirection == 0 then heightDirection = -1;
        
        //Create a column using the currently selected hight value.
        for (j=0;j<(heightIndex/16)+(sizeY);j++)
        {
            var inst_y = yy+(16*j)-(heightIndex*heightDirection)+16;
        
            if xInterval > RAIDBOUND_Lower && xInterval < RAIDBOUND_Upper && inst_y < stoneLayer-((10-_flatY)*16)
            { continue; }
        
            if j > (heightIndex/16)+irandom_range(6,10) then tileType = stone_tileset else tileType = dirt_tileset;
            var inst = instance_create(xInterval,inst_y,tileType);
            inst.visible = false; //optimize
        }
            
    }
}

else if time == 44
{
    //Ore veins
    var oreHeight = yy+(16*16);
    var oreHeightMax = yy+(59*16);
    var spawnAmt = 20;
    var veinAmt_max = 7;
    var veinAmt_min = 3;
    
    for (i=0;i<spawnAmt;i++)
    {
        var xInterval_Original = 16*irandom(160);
        var yInterval_Original = floor(irandom_range(oreHeight,oreHeightMax)/16)*16 //The lowest possible place a tree may spawn. -9 is the lowest possible tile height.
        var yInterval = yInterval_Original;
        var xInterval = xInterval_Original;
        var veinAmt = irandom_range(veinAmt_min-1,veinAmt_max+1); //Ensure a vein of at least 3 ore.
        
        
        //-------PLACE ORE--------
        //NOTE: 
        for (_k=0;_k<2;_k++)
        {
            switch _k
            {
                //---------SPAWN ORE-----------
                
                case 0:
                {
                    for (j=0;j<veinAmt;j++)
                    {
                        while position_meeting(xInterval,yInterval,ore_type) || yInterval <= oreHeight
                        { yInterval += choose(16,-16,0); xInterval += choose(16,-16); }
                        
                        //Replace tiles with Ore Tiles.
                        if position_meeting(xInterval,yInterval,TILE) 
                        {
                            with instance_position(xInterval,yInterval,TILE) instance_destroy();
                            var t = instance_create(xInterval,yInterval,ore_type);
                            
                            xInterval = xInterval_Original;
                            yInterval = yInterval_Original;
                        }
                    }
                }
                break;
                
                //--------------SPAWN ESSENCE ORE---------------
                case 1:
                {
                    xInterval = 16*irandom(160);
                    yInterval = floor(irandom_range(oreHeight,oreHeightMax)/16)*16;
                    
                    //Replace tiles with Ore Tiles.
                    if position_meeting(xInterval,yInterval,TILE) 
                    {
                        with instance_position(xInterval,yInterval,TILE) instance_destroy();
                        var t = instance_create(xInterval,yInterval,obj_essenceOre);
                        
                        xInterval = xInterval_Original;
                        yInterval = yInterval_Original;
                    }
                }
                break;
            }
        }
    }
}

else if time == 45
{
    
    //Cleanup enemies
    if instance_exists(ENEMY) then with ENEMY { if insideView(x,y) == false then instance_destroy(); }
    
    //Spawn trees or spawners
    if tree_bool == true
    {
        var spawnAmt = irandom_range(5,15);
        
        for (i=0;i<spawnAmt;i++)
        {
            var treeHeight = irandom_range(4,7);
            var xInterval_Original = floor(irandom(room_width)/16)*16;
            var yInterval_Original = yy+(16*9); //The lowest possible place a tree may spawn. -9 is the lowest possible tile height.
            var yInterval = yInterval_Original;
            var xInterval = xInterval_Original;
            var variance = 16*choose(1,-1);
            
            //This for loop creates 1 tree.
            for (j=0;j<treeHeight;j++)
            {
                //Check and correct Y position.
                if (xInterval >= RAIDBOUND_Lower && xInterval <= RAIDBOUND_Upper) { break; }
                while position_meeting(xInterval,yInterval+16,obj_tree) || 
                    position_meeting(xInterval,yInterval,obj_tree) 
                    { xInterval += variance; }
                   
                //Place tree tiles using previously used xInterval variable.
                while position_meeting(xInterval,yInterval,OBSTA) yInterval -= 16;
                while position_meeting(xInterval,yInterval,obj_tree) yInterval -= 16;
                
                //(y+16) because the trees spawn one tile above the ground
                var t = instance_create(xInterval,yInterval,obj_tree);
                
                if j == treeHeight-1 then t.canopy = true;
                
                xInterval = xInterval_Original;
                yInterval = yInterval_Original;
            }
        }
    }
    
    //Spawners!
    if spawner_bool == true
    {
       scr_spawnWorldCreatures(spawner_type);
    }
}

else if time == 46
{
    //Spawn Caves
    var pocketHeight = yy+(16*16);
    var pocketHeightMax = yy+(59*16);
    var spawnAmt = 15; //How many caves
    var chestAmt = 10; //How many caves have chests
    
    for (i=0;i<spawnAmt;i++)
    {
        var xInterval_Original = 16*irandom(160);
        var yInterval_Original = floor(irandom_range(pocketHeight,pocketHeightMax)/16)*16 //The lowest possible place a tree may spawn. -9 is the lowest possible tile height.
        var yInterval = yInterval_Original;
        var xInterval = xInterval_Original;
        var holeAmt = irandom(6);
        
        //Correct origin coordinates
        while yInterval <= pocketHeight { yInterval += 16; }
        
        //Punch a hole
        
        var pos = position_meeting(xInterval,yInterval,TILE);
        
        for (j=0;j<(holeAmt*16)*2;j++)
        {
            
            if pos
            { 
                with TILE
                {
                    if point_distance(xInterval,yInterval,x,y) <= (holeAmt*16)+8
                    {
                        instance_create(x,y,obj_nullLight);
                        instance_destroy();
                    }
                }
                
                //Chest spawning
                if chestAmt > 0 && j == ((holeAmt*16)*2)-1
                {
                    if position_meeting(xInterval,yInterval,obj_nullLight)
                    {
                        while position_meeting(xInterval,yInterval+16,obj_nullLight) { yInterval+=16; }
                        
                        instance_create(xInterval,yInterval,obj_chest); 
                        chestAmt -= 1; 
                        //print("chest");
                    }
                }
            }
        }
        
    }
}
else if time == 47
{
    //Place totems
    var hive_x = floor(irandom_range(16,room_width-16)/16)*16;
    var hive_y = floor(irandom_range(stoneLayer+16*8,room_height-16)/16)*16;
    var shove = choose(1,-1);
    
    while (position_meeting(hive_x,hive_y,FLATLAND) || position_meeting(hive_x,hive_y,obj_nullLight)) { hive_x+=16*shove; }
    
    if position_meeting(hive_x,hive_y,OBSTA) { with instance_position(hive_x,hive_y,OBSTA) { instance_destroy(); } }
    
    instance_create(hive_x,hive_y,totem_type);
        
        //print("HERE: "+string(hive_x)+","+string(hive_y));

    //bottom Border layer
    for(i=0;i<sizeX*2+20;i++)
    {
        var _x = xx+(i*16);
        var _y = yy+16*sizeY;
    
        if !collision_point(_x,_y-2,TILE_ALL,false,true)
        {
            instance_create(_x,_y,obj_stone);
        }
    }
    
    //Place Pie
    if !instance_exists(obj_pie) then instance_create((sizeX*16)+((_flatX*16)/2),yy-16,obj_pie);
    
    //Spawn the player object.
    if !instance_exists(obj_player) then instance_create(obj_pie.x,obj_pie.y-16*2,obj_player);
}
//Update tiles
else if (time >= 48 && time <= 63) // 16 steps
{
    var _tiles = ceil(instance_number(TILE)/8)*(time-47); //How many tiles are affected this step.
    var _previous_tiles = ceil(instance_number(TILE)/8)*(time-48); //Starting position
    
    for(i=_previous_tiles;i<_tiles;i++)
    {
        var _t = instance_find(TILE,i);
        
        if instance_exists(_t) 
        {
            with _t 
            { event_user(1); }
        } 
        else break;
    }
    
    //APPLY BACKGROUNDS
    background_index[0] = bkg_overworldSky;
    background_index[1] = bkg_overworldNightSky;
    background_index[2] = background_far;
    background_index[3] = background_close;
    background_index[4] = foreground;
}
else if time == 64 then with NOCOL event_user(1);
else if time == 65 
{
    //Reenable deactivation and destroy the region shifter
    worldControl.deactivation_enabled = true;
}
else if time == 70
{
    //Cleanup (again)
    if instance_exists(obj_itemDrop) then with obj_itemDrop { instance_destroy(); }
    
    worldControl.alarm[0] = 1;
    instance_destroy();
}


