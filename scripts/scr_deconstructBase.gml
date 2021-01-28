///scr_deconstructBase();
//Destroy the flatlands!!!!!! :::::::::::::####:#$ Gremlin script... ? no.. unless?

//Only useable in a region room during intermission.
if room == rm_zero || room == rm_tutorial
{
    if interm == true && (instance_exists(PLRTILE) || instance_exists(PLR_NOCOL))
    {
        for(j=0;j<3;j++)
        {
            //Run the clean loop thrice - this must be done because otherwise this script would only run once.
            for(i=0;i<instance_number(PLRTILE);i++)
            {
                with instance_find(PLRTILE,i) //Instance_find is 0 indexed.
                {
                    if (x > RAIDBOUND_Lower && x < RAIDBOUND_Upper)
                    {
                        itemDrop = true;
                        instance_destroy();
                    }
                }
                
                with instance_find(PLR_NOCOL,i)
                {
                    if (x > RAIDBOUND_Lower && x < RAIDBOUND_Upper)
                    {
                        itemDrop = true;
                        instance_destroy();
                    }
                }
            }
        }
    }
}
