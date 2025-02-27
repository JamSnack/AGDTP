///GROUND CONNECTION LOGIC

/*Remember past tiles.
Try to go down if possible, then go left or right depending on the tiles. If it can't
do that then go up and continue checking until it can do neither.
If loops onto a past tile then kill itself.
*/

//***** ACTION MUST BE DELAYED A FRAME. ALARM USAGE IS NECESSARY. *****

//init iterator.
var x1 = x;
var y1 = y;

//Remember past tiles
var pastTiles = ds_list_create();
var leftFail = false;

while true
{

    if isGrounded(x1,y1) { break; }
    
    if leftFail == false
    {
        if collision_point(x1,y1,PLRTILE,false,true) { ds_list_add(pastTiles,collision_point(x1,y1,PLRTILE,false,true)); };
        if collision_point(x1,y1,PLR_NOCOL,false,true) { ds_list_add(pastTiles,collision_point(x1,y1,PLR_NOCOL,false,true)); };
    
        //Iterator, down-left-up-right priority.
        
        //Down
        if collision_point(x1,y1+16,PLRTILE,false,true) && 
        ds_list_find_index(pastTiles,collision_point(x1,y1+16,PLRTILE,false,true)) == -1 
            { y1 += 16; continue; }
        else if collision_point(x1,y1+16,PLR_NOCOL,false,true) && 
        ds_list_find_index(pastTiles,collision_point(x1,y1+16,PLR_NOCOL,false,true)) == -1 
            { y1 += 16; continue; }
              
        
        //Left
        else if collision_point(x1-16,y1,PLRTILE,false,true) && 
        ds_list_find_index(pastTiles,collision_point(x1-16,y1,PLRTILE,false,true)) == -1 
            { x1 -= 16; continue; }
        else if collision_point(x1-16,y1,PLR_NOCOL,false,true) && 
        ds_list_find_index(pastTiles,collision_point(x1-16,y1,PLR_NOCOL,false,true)) == -1 
            { x1 -= 16; continue; }
            
            
        //Up
        else if collision_point(x1,y1-16,PLRTILE,false,true) && 
        ds_list_find_index(pastTiles,collision_point(x1,y1-16,PLRTILE,false,true)) == -1 
            { y1 -= 16; continue; }
        else if collision_point(x1,y1-16,PLR_NOCOL,false,true) && 
        ds_list_find_index(pastTiles,collision_point(x1,y1-16,PLR_NOCOL,false,true)) == -1 
            { y1 -= 16; continue; }               
            
            
        //Right
        else if collision_point(x1+16,y1,PLRTILE,false,true) && 
        ds_list_find_index(pastTiles,collision_point(x1+16,y1,PLRTILE,false,true)) == -1 
            { x1 += 16; continue; }
        else if collision_point(x1+16,y1,PLR_NOCOL,false,true) && 
        ds_list_find_index(pastTiles,collision_point(x1+16,y1,PLR_NOCOL,false,true)) == -1 
            { x1 += 16; continue; }       
            
            
        else 
        { 
            leftFail = true; 
            x1 = x; y1 = y; 
            ds_list_clear(pastTiles);
            continue; 
        }
    }
    
    
    else /* ----------------------------------
    -------------------
    -------------------
    LEFT FAIL = TRUE;
    ------------------
    ------------------
        */
    {
        if collision_point(x1,y1,PLRTILE,false,true) { ds_list_add(pastTiles,collision_point(x1,y1,PLRTILE,false,true)); };
        if collision_point(x1,y1,PLR_NOCOL,false,true) { ds_list_add(pastTiles,collision_point(x1,y1,PLR_NOCOL,false,true)); };
    
        //Iterator, down-right-up-left priority.
        
        //Down
        if collision_point(x1,y1+16,PLRTILE,false,true) && 
        ds_list_find_index(pastTiles,collision_point(x1,y1+16,PLRTILE,false,true)) == -1 
            { y1 += 16; continue; }
        else if collision_point(x1,y1+16,PLR_NOCOL,false,true) && 
        ds_list_find_index(pastTiles,collision_point(x1,y1+16,PLR_NOCOL,false,true)) == -1 
            { y1 += 16; continue; }
              
        //Right
        else if collision_point(x1+16,y1,PLRTILE,false,true) && 
        ds_list_find_index(pastTiles,collision_point(x1+16,y1,PLRTILE,false,true)) == -1 
            { x1 += 16; continue; }
        else if collision_point(x1+16,y1,PLR_NOCOL,false,true) && 
        ds_list_find_index(pastTiles,collision_point(x1+16,y1,PLR_NOCOL,false,true)) == -1 
            { x1 += 16; continue; } 
            
        //Up
        else if collision_point(x1,y1-16,PLRTILE,false,true) && 
        ds_list_find_index(pastTiles,collision_point(x1,y1-16,PLRTILE,false,true)) == -1 
            { y1 -= 16; continue; }
        else if collision_point(x1,y1-16,PLR_NOCOL,false,true) && 
        ds_list_find_index(pastTiles,collision_point(x1,y1-16,PLR_NOCOL,false,true)) == -1 
            { y1 -= 16; continue; }               
            
        //Left
        else if collision_point(x1-16,y1,PLRTILE,false,true) && 
        ds_list_find_index(pastTiles,collision_point(x1-16,y1,PLRTILE,false,true)) == -1 
            { x1 -= 16; continue; }
        else if collision_point(x1-16,y1,PLR_NOCOL,false,true) && 
        ds_list_find_index(pastTiles,collision_point(x1-16,y1,PLR_NOCOL,false,true)) == -1 
            { x1 -= 16; continue; } 
            
            
        else { instance_destroy();}
    
    }
    break;
}

ds_list_destroy(pastTiles);

