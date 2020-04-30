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
        if position_meeting(x1,y1,PLRTILE) { ds_list_add(pastTiles,instance_position(x1,y1,PLRTILE)); };
        if position_meeting(x1,y1,PLR_NOCOL) { ds_list_add(pastTiles,instance_position(x1,y1,PLR_NOCOL)); };
    
        //Iterator, down-left-up-right priority.
        
        //Down
        if position_meeting(x1,y1+16,PLRTILE) && 
        ds_list_find_index(pastTiles,instance_position(x1,y1+16,PLRTILE)) == -1 
            { y1 += 16; continue; }
        else if position_meeting(x1,y1+16,PLR_NOCOL) && 
        ds_list_find_index(pastTiles,instance_position(x1,y1+16,PLR_NOCOL)) == -1 
            { y1 += 16; continue; }
              
        
        //Left
        else if position_meeting(x1-16,y1,PLRTILE) && 
        ds_list_find_index(pastTiles,instance_position(x1-16,y1,PLRTILE)) == -1 
            { x1 -= 16; continue; }
        else if position_meeting(x1-16,y1,PLR_NOCOL) && 
        ds_list_find_index(pastTiles,instance_position(x1-16,y1,PLR_NOCOL)) == -1 
            { x1 -= 16; continue; }
            
            
        //Up
        else if position_meeting(x1,y1-16,PLRTILE) && 
        ds_list_find_index(pastTiles,instance_position(x1,y1-16,PLRTILE)) == -1 
            { y1 -= 16; continue; }
        else if position_meeting(x1,y1-16,PLR_NOCOL) && 
        ds_list_find_index(pastTiles,instance_position(x1,y1-16,PLR_NOCOL)) == -1 
            { y1 -= 16; continue; }               
            
            
        //Right
        else if position_meeting(x1+16,y1,PLRTILE) && 
        ds_list_find_index(pastTiles,instance_position(x1+16,y1,PLRTILE)) == -1 
            { x1 += 16; continue; }
        else if position_meeting(x1+16,y1,PLR_NOCOL) && 
        ds_list_find_index(pastTiles,instance_position(x1+16,y1,PLR_NOCOL)) == -1 
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
        if position_meeting(x1,y1,PLRTILE) { ds_list_add(pastTiles,instance_position(x1,y1,PLRTILE)); print('add'); };
        if position_meeting(x1,y1,PLR_NOCOL) { ds_list_add(pastTiles,instance_position(x1,y1,PLR_NOCOL)); };
    
        //Iterator, down-right-up-left priority.
        
        //Down
        if position_meeting(x1,y1+16,PLRTILE) && 
        ds_list_find_index(pastTiles,instance_position(x1,y1+16,PLRTILE)) == -1 
            { y1 += 16; continue; }
        else if position_meeting(x1,y1+16,PLR_NOCOL) && 
        ds_list_find_index(pastTiles,instance_position(x1,y1+16,PLR_NOCOL)) == -1 
            { y1 += 16; continue; }
              
        //Right
        else if position_meeting(x1+16,y1,PLRTILE) && 
        ds_list_find_index(pastTiles,instance_position(x1+16,y1,PLRTILE)) == -1 
            { x1 += 16; continue; }
        else if position_meeting(x1+16,y1,PLR_NOCOL) && 
        ds_list_find_index(pastTiles,instance_position(x1+16,y1,PLR_NOCOL)) == -1 
            { x1 += 16; continue; } 
            
        //Up
        else if position_meeting(x1,y1-16,PLRTILE) && 
        ds_list_find_index(pastTiles,instance_position(x1,y1-16,PLRTILE)) == -1 
            { y1 -= 16; continue; }
        else if position_meeting(x1,y1-16,PLR_NOCOL) && 
        ds_list_find_index(pastTiles,instance_position(x1,y1-16,PLR_NOCOL)) == -1 
            { y1 -= 16; continue; }               
            
        //Left
        else if position_meeting(x1-16,y1,PLRTILE) && 
        ds_list_find_index(pastTiles,instance_position(x1-16,y1,PLRTILE)) == -1 
            { x1 -= 16; continue; }
        else if position_meeting(x1-16,y1,PLR_NOCOL) && 
        ds_list_find_index(pastTiles,instance_position(x1-16,y1,PLR_NOCOL)) == -1 
            { x1 -= 16; continue; } 
            
            
        else { instance_destroy(); }
    
    }
    break;
}

ds_list_destroy(pastTiles);

