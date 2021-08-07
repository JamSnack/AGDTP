///scr_getEnemyInfo(object_index);
//For use in the hudControl event. Returns information on currently selected enemy in the WAVE menu.

var enemy = argument0;
var name = "";
var hp = "Max HP: "+string(scr_enemyHpIndex(enemy));

switch enemy
{
    case obj_gremlin: { name = "Gremlin"; } break;
    case obj_crab: { name = "Crab"; } break;
    case obj_crabKing: { name = "Crab King"; } break;
    case obj_stoneGremlin: { name = "Stone Gremlin"; } break;
    case obj_grassGremlin: { name = "Grass Gremlin"; } break;
    case obj_spherePylon: { name = "Sphere Pylon"; } break;
    case obj_shadowGremlin: { name = "Shadow Gremlin"; } break;
    case obj_hornedHapp: { name = "Horned Happ"; } break;
    case obj_beeMinion: { name = "Bee Minion"; } break;
    case obj_drillin: { name = "Drillin"; } break;
    case obj_sweetWorm: { name = "Sweet Worm"; } break;
    case obj_sandMenace: { name = "Sand Menace"; } break;
    case obj_sphereMinion: { name = "Sphere Minion"; } break;
    case obj_mackerel: { name = "Summer Mackerel"; } break;
    
    //Bosses
    case obj_sphereKing: {name = "Sphere King";} break;
    case obj_nilmerg: {name = "Nilmerg";} break;
    case obj_bombKing: {name = "Bomb King";} break;
    case obj_bliplo: {name = "Bliplo";} break;
    
    default: name = "Stranger"; hp = "Unknown";
}

return name+"#"+hp;

