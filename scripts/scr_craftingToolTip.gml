///scr_craftingToolTip(craftingTableSet,itemID);
text[0] = "" //Item Name
text[1] = ""; //Item Description

switch argument0
{
    default: //default
    {
        switch argument1
        {
            case 0: { text[0] = "Workbench"; text[1] = "Used for crafting#basic things."; text[2] = "Stick x 5"} break; //Workbench
            case 1: { text[0] = "Ladder"; text[1] = "Place this and climb!"; text[2] = "Stick x 2"} break; //Workbench
            case 2: { text[0] = "Wooden Stilt"; text[1] = "Provides support for your structures."; text[2] = "Stick x 2"} break;
        }
    }
    break;
    
    case 1: //workbench items
    {
        switch argument1
        {
            case 0: { text[0] = "Green Sword"; text[1] = "Damage: 6#Speed: 2"; text[2] = "Copper Ore x 12#Stick x 5"} break; //Green Sword
            case 1: { text[0] = "Green Pickaxe"; text[1] = "Tier: 0#Speed: 2"; text[2] = "Copper Ore x 8#Stick x 5" } break; //Green Pick
            case 2: { text[0] = "Packed Dirt"; text[1] = "Health: 10"; text[2] = "Dirt Clump x 4" } break;
            case 3: { text[0] = "Copper Turret"; text[1] = "Health: 5"; text[2] = "Stone Piece x 30#Copper Ore x 15#Stick x 5" } break;
            case 4: { text[0] = "Gremlin Talisman"; text[1] = "Consumable"; text[2] = "Stone Piece x 5#Synthetic Essence x 5" } break;
            case 5: { text[0] = "Platform"; text[1] = "Tile"; text[2] = "Stick x 2" } break;
            case 6: { text[0] = "Token Bomb"; text[1] = "Consumable"; text[2] = "Stone Piece x 10#Synthetic Essence x 2#Copper Ore x 2" } break;
            case 7: { text[0] = "Packed Stone"; text[1] = "Health: 25"; text[2] = "Stone Piece x 8" } break;
            case 8: { text[0] = "Mod Bench"; text[1] = "Use to apply Mod Tags#to your equipment."; text[2] = "Synthetic Essence x 30#Copper Ore x 15" } break;
        }
    }
}
