/// scr_getRegionCost(region_name);
var region_name = argument0;

switch region_name
{
    case "GRASSLANDS": { return 50; } break;
    case "COVE": { return 100; } break;
    default: { return 0; }
}
