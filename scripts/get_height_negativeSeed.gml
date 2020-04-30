///get_height_negativeSeed(terrainType);
var str;

switch argument0
{ 
    case "FLAT": { str = choose("1111000011110000","111111000000111000"); } break;
    case "HILL": { str = choose("1110001110000","1010000110110"); } break;
}

return str;
