///scr_treeCreate(x,y);

//Spawn trees
var treeHeight = irandom_range(4,7);
var xInterval = argument0;
var yInterval = argument1;

for (_tree=0;_tree<treeHeight;_tree++)
{      
    print(_tree);
    //Place tree tiles using previously used xInterval variable.
    if position_meeting(xInterval,yInterval,OBSTA) { break; }
    while position_meeting(xInterval,yInterval,obj_tree) { yInterval -= 16; }
    
    //(y+16) because the trees spawn one tile above the ground
    var t = instance_create(xInterval,yInterval,obj_tree);
    
    
    //--- Update the tree tiles locally b/c using ev_user 1 will kill out of bounds trees.
    if _tree == treeHeight-1 
    {
        t.image_index = 2;
        t.canopy = true;
        scr_tileUpdate(xInterval,yInterval);
    }
    else if _tree == 0
    {
        //Bottom piece
        t.image_index = 0;
    } else if _tree < treeHeight-1 && _tree > 0
    {
        //Center
        t.image_index = 1;
    }
    
}

//Ensure that the tree is preserved outside of bounds.
with obj_tree scr_deactivateOffscreen(id);
