///scr_removeEssence(cost);
//This script is mainly used in Ui interactions that require essence.
var _cost = argument0;

if currency_essence >= _cost
{
    //Transaction complete!
    currency_essence -= _cost;
    return 1;
}
else
{
    scr_hudMessage("Not enough essence.",global.fnt_menu,2,0,c_red,0);
    return 0;
}
