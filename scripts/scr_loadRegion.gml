///scr_loadRegion(preset);
//MODIFIED FOR USE IN REGION SHIFTING!

//----------GENERATE THE REGION VARIABLES----------------
randomize();
var preset = argument0;

/*-------- Presets:
-- "TUTORIAL"
*/

//Apply presets
if preset == "TUTORIAL"
{
    heightSeed = "554334567776554";
    heightNegativeSeed = "111111111000000111100";
}


//FlatLands definition
var _flatX = 32;
var _flatY = 20;
var flatLandTotal = _flatX*_flatY;


//Total amount of positions to iterate through.
var worldLandTotal = ((sizeX*sizeY)*2)+flatLandTotal;

//------CLOCK---------

if time == 1
{
    //- Reactivate everything, then destroy it.
    if instance_exists(TILE) then with TILE { if object_index != obj_pie then instance_destroy(); }
}

else if time == 2
{
    if instance_exists(PLRTILE) then with PLRTILE { if !(x > RAIDBOUND_Lower && x < RAIDBOUND_Upper) { instance_destroy(); } }
    if instance_exists(obj_nullLight) then with obj_nullLight { instance_destroy(); }
}

else if time == 3
{
    if instance_exists(NOCOL) then with NOCOL { if object_get_parent(object_index) != PLR_NOCOL then instance_destroy(); }
    if instance_exists(obj_itemDrop) then with obj_itemDrop { if !(x > RAIDBOUND_Lower && x < RAIDBOUND_Upper) then instance_destroy(); }
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
            if j > (heightIndex/16)+irandom_range(6,10) then tileType = obj_stone else tileType = obj_dirt;
            var inst = instance_create(xInterval,yy+(16*j)-(heightIndex*heightDirection)+16,tileType);
            inst.visible = false; //optimize
            
            if inst.x > RAIDBOUND_Lower && inst.x < RAIDBOUND_Upper && inst.y < stoneLayer
            { with inst instance_destroy(); }
        }
            
    }
}

else if time == 44
{
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
}

else if time == 45
{
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
            
            if j == treeHeight-1 then t.canopy = true;
            
            xInterval = xInterval_Original;
            yInterval = yInterval_Original;
        }
    }
}

else if time == 46
{
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
}
else if time == 47
{
    //Border layer
    for(i=0;i<sizeX*2+20;i++)
    {
        instance_create(xx+(i*16),yy+32*sizeY,OBSTA);
    }
    
    //Place Pie
    if !instance_exists(obj_pie) then instance_create((sizeX*16)+((_flatX*16)/2),yy-16,obj_pie);
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
}
else if time == 64 then with NOCOL event_user(1);
else if time == 65 
{
    //Cleanup (again)
    if instance_exists(obj_itemDrop) then with obj_itemDrop { if insideView(x,y) == false then instance_destroy(); }
    if instance_exists(ENEMY) then with ENEMY { if insideView(x,y) == false then instance_destroy(); }

    //Reenable deactivation
    worldControl.deactivation_enabled = true;
    instance_destroy();
}


