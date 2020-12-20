///scr_buyUpgrade(UpgradeName);
var upgrade = argument0; //The name of the upgrade.
var essence = scr_getInvenItemAmt(ITEMID.item_gremEssence);

//Can we buy it?
//NOTE: Cost for the alpha will probably just double in price.
//Buy it!
switch upgrade
{
    case "TILE_REGEN":
    {
        var cost = tileRegenRate*25;
        if essence >= cost
        {
            scr_invenRemoveItem(ITEMID.item_gremEssence,cost,ITEMTYPE.def,false,-1,noone)
            tileRegenRate += 1;
        }
        else 
        {
            scr_hudMessage("Not enough Gremlin Essence!",global.fnt_Ui,5,0,c_red,0);
            exit;
        }
    }
    break;
    
    case "TILE_LEVEL":
    {
        var cost = tileLevel*50;
        if essence >= cost
        {
            scr_invenRemoveItem(ITEMID.item_gremEssence,cost,ITEMTYPE.def,false,-1,noone)
            tileLevel += 1;
        }
        else 
        {
            scr_hudMessage("Not enough Gremlin Essence!",global.fnt_Ui,5,0,c_red,0);
            exit;
        }
    }
    break;
    
    case "POWER_STORAGE":
    {
        var cost = (energyMax-4)*100; //5 is energy max's default number. max-4 = a cost of 100 for level 1.
        if essence >= cost
        {
            scr_invenRemoveItem(ITEMID.item_gremEssence,cost,ITEMTYPE.def,false,-1,noone)
            energyMax += 1;
        }
        else 
        {
            scr_hudMessage("Not enough Gremlin Essence!",global.fnt_Ui,5,0,c_red,0);
            exit;
        }
    }
    break;
}


//If the script finishes, then the upgrade was a success.
with gameControl event_user(0); //save the game
scr_hudMessage("Upgrade successful!",global.fnt_Ui,5,0,c_green,0);
scr_playSound(snd_modificationSuccess,false,8,obj_player.x,obj_player.y,1);
