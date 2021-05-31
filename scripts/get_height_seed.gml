/// get_height_seed(strLength, terrainType, startHeight, maxHeight, minHeight)
var strLength = argument0, terrainType = argument1;
var str = "";
var digit = argument2;
var max_height = argument3;
var min_height = argument4;

for (i=0;i<strLength;i++)
{
    //Add to the string based on type of terrain.
    switch terrainType
    { 
        case "FLAT": { digit += choose(0,0,0,-1,-1,-1,1,1,1,-2,2); } break;
        case "HILL": { digit += choose(0,0,-1,1,1,1); } break;
    }
    if digit < min_height then digit = min_height else if digit > max_height then digit = max_height;
    str = str+string(digit);
}

return str;
