///get_height_seed(stringLength,terrainType);
var strLength = argument0;
var str = "";
var digit = 1;

for (i=0;i<strLength;i++)
{
    //Add to the string based on type of terrain.
    switch argument1
    { 
        case "FLAT": { digit += choose(0,0,0,-1,-1,-1,1,1,1,-2,2); } break;
        case "HILL": { digit += choose(0,0,-1,1,1,1,-2,2,2,3,-3); } break;
    }
    if digit <= 0 then digit = 1 else if digit >= 10 then digit = 9;
    str = str+string(digit);
}
print(str);
return str;
