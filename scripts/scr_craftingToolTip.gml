///scr_craftingToolTip(itemID);
text[0] = "" //Item Name
text[1] = ""; //Item Description

mats = 0; // What type of material to look for
matsAmt = 0; // How much of the material to look for/consume.
itemID = argument0; //The ID of the item to craft.

//UPDATE VARIABLES FOR TEXT USE
scr_getRecipe(itemID);
