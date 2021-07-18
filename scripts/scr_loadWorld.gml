/// scr_loadWorld(preset)
///scr_loadWorld(preset);


//FlatLands and RAIDBOUND definition
var _flatX = 32;
var _flatY = 20;
var flatLandTotal = _flatX*_flatY;

var xx = 0;
var yy = room_height/2-48; //-48 includes 3 rows of tiles inside the room.

var sizeX = 64; //64x30 target world size. Repeated on the other side of the flat lands.
var sizeY = 30;

for(i=0;i<floor(flatLandTotal);i++)
{
    //Raid boundaries defined inside the worldControl object.
    var column = floor(i/_flatX);
    
    if i == 0 then RAIDBOUND_Lower = xx+(16*sizeX)-(8);
    if i == 0 then RAIDBOUND_Upper = (16*sizeX)+(_flatX*16)-(8);
    
    //Spawn flatland blocks.
    instance_create(xx+(16*sizeX)+(16*i)-(column*16*_flatX),yy+(16*column),FLATLAND);
}


var i = instance_create(0,0,region_shifter);
i.next_region = "GRASSLANDS";

/* FUCK YOU CODE! GET BLASTED!
randomize();
var preset = argument0;

-------- Presets:
-- "TUTORIAL"

var heightSeed = get_height_seed(15,"FLAT", 1, 10,1);
var heightNegativeSeed = get_height_negativeSeed("FLAT"); //Random digit seed defining whether or not a column will grow upwards or downwards.

//Apply presets
if preset == "TUTORIAL"
{
    heightSeed = "554334567776554";
    heightNegativeSeed = "111111111000000111100";
}


//Total amount of positions to iterate through.
var worldLandTotal = ((sizeX*sizeY)*2)+flatLandTotal;


//Dirt and Stone layer
for(i=0;i<160;i++)
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
        var tile_y = yy+(16*j)-(heightIndex*heightDirection)+16;
    
        if tile_y >= (yy+(20*16)) || (xInterval < RAIDBOUND_Lower || xInterval > RAIDBOUND_Upper)
        {
            if j > (heightIndex/16)+irandom_range(6,10) then tileType = obj_stone else tileType = obj_dirt;
            var inst = instance_create(xInterval,tile_y,tileType);
        }
    }
        
}

//Ore veins
var oreHeight = yy+(16*16);
var oreHeightMax = yy+(30*16);
var spawnAmt = 10;
var veinAmt = irandom(4)+3; //Ensure a vein of at least 3 ore.

for (i=0;i<spawnAmt;i++)
{
    var xInterval_Original = 16*irandom(160);
    var yInterval_Original = floor(irandom_range(oreHeight,oreHeightMax)/16)*16 //The lowest possible place a tree may spawn. -9 is the lowest possible tile height.
    var yInterval = yInterval_Original;
    var xInterval = xInterval_Original;
    
    
    //-------PLACE ORE--------
    //NOTE: 
    for (_k=0;_k<2;_k++)
    {
        switch _k
        {
            //---------SPAWN COPPER ORE-----------
            
            case 0:
            {
                for (j=0;j<veinAmt;j++)
                {
                    while position_meeting(xInterval,yInterval,obj_copperOre) || yInterval <= oreHeight
                    { yInterval += choose(16,-16,0); xInterval += choose(16,-16); }
                    
                    //Replace tiles with Ore Tiles.
                    if position_meeting(xInterval,yInterval,TILE) 
                    {
                        with instance_position(xInterval,yInterval,TILE) instance_destroy();
                        var t = instance_create(xInterval,yInterval,obj_copperOre);
                        
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


//Spawn trees
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
        
        if j == treeHeight-1 then { t.canopy = true; depth = -1; }
        
        xInterval = xInterval_Original;
        yInterval = yInterval_Original;
    }
}

//Spawn Caves
var pocketHeight = yy+(16*16);
var pocketHeightMax = yy+(30*16);
var spawnAmt = 5;
var chestAmt = 10;

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

//Spawn Hive Totem!
if region == "GRASSLANDS"
{
    var hive_x = floor(irandom_range(16,room_width-16)/16)*16;
    var hive_y = floor(irandom_range(stoneLayer+16*8,room_height-16)/16)*16;
    var shove = choose(1,-1);
    
    while (position_meeting(hive_x,hive_y,FLATLAND) || position_meeting(hive_x,hive_y,obj_nullLight)) { hive_x+=16*shove; }
    
    if position_meeting(hive_x,hive_y,OBSTA) { with instance_position(hive_x,hive_y,OBSTA) { instance_destroy(); } }
    
    instance_create(hive_x,hive_y,obj_hiveTotem);
    
    //print("HERE: "+string(hive_x)+","+string(hive_y));
}


//Bottom border layer
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
instance_create((sizeX*16)+((_flatX*16)/2),yy-15,obj_pie);
*/
//Update tiles
with TILE event_user(1);
with NOCOL event_user(1);
with FLATLAND event_user(1);

//Cleanup
if instance_exists(obj_itemDrop) then with obj_itemDrop instance_destroy();



//Game loaded in obj_menuLogo Glob Left Released event
//scr_loadGame();

