///scr_getHighestBasePoint();
//Returns the highest point of the player's base.
var return_y = world_height;

if instance_exists(PLRTILE)
{
    with PLRTILE
    {
        if (x > RAIDBOUND_Lower && x < RAIDBOUND_Upper) && y < return_y
        {
            return_y = y;
        }
    }
}


//print("Highest Point: "+string(return_y));
return return_y;
