///scr_deconstructBase();
//Destroy the flatlands!!!!!! :::::::::::::####:#$ Gremlin script... ? no.. unless?

//Only useable in a region room during intermission.
if room == rm_zero
{
    if interm == true
    {
        for(i=0;i<instance_number(PLRTILE);i++)
        with instance_find(PLRTILE,i)
        {
            if (x > RAIDBOUND_Lower && x < RAIDBOUND_Upper)
            {
                itemDrop = true;
                instance_destroy();
            } else print('fuck');
        }
    }
}
