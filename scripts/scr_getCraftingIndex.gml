///scr_getCraftingIndex(craftingMenu, craftingID);
//Find the true itemID of the item being crafted.


var craftID = argument1;
var returnID;

switch argument0
{
    //-----------------------------WORKBENCH--------------------
    case 1:
    {
        switch craftID
            {
                case 0: {returnID = "GREEN_SWORD"} break;
                case 1: {returnID = "GREEN_PICK"} break;
                case 2: {returnID = "PACKED_DIRT"} break;
                case 3: {returnID = "TURRET_COPPER"} break;
                case 4: {returnID = "GREM_TALISMAN"} break;
                case 5: {returnID = "PLATFORM" } break;
                case 6: {returnID = "BOMB" } break;
                case 7: {returnID = "PACKED_STONE" } break;
                case 8: {returnID = ITEMID.tile_modBench } break;
                case 9: {returnID = ITEMID.tile_battery } break;
                case 10: {returnID = ITEMID.weapon_acornRifle } break;
            }
    }
    break;
    
    //-----------------------------DEFAULT---------------------
    case 2:
    {
        switch craftID
            {
                case 0: {returnID = "WORKBENCH"} break;
                case 1: {returnID = "LADDER"} break;
                case 2: {returnID = ITEMID.tile_woodenStilt} break;
            }
    }
    break;
}

return returnID;
