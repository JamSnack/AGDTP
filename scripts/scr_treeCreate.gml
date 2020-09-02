///scr_treeCreate(x,y);

//Spawn trees
var treeHeight = irandom_range(4,7);
var xInterval = argument0;
var yInterval = argument1;

for (j=0;j<treeHeight;j++)
{      
    //Place tree tiles using previously used xInterval variable.
    if position_meeting(xInterval,yInterval,OBSTA) { j = treeHeight-1; }
    while position_meeting(xInterval,yInterval,obj_tree) { yInterval -= 16; }
    
    //(y+16) because the trees spawn one tile above the ground
    var t = instance_create(xInterval,yInterval,obj_tree);
    
    if j == treeHeight-1 then t.canopy = true;
    
    scr_tileUpdate(xInterval,yInterval);
}
