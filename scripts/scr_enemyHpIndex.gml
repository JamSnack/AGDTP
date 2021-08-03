///scr_enemyHpIndex(enemy_object);
//Return the tile's base HP.

switch argument0
{
    case obj_gremlin: { return 16; } break;
    case obj_crab: { return 16; } break;
    case obj_crabKing: { return 225; } break;
    case obj_stoneGremlin: { return 32; } break;
    case obj_grassGremlin: { return 24; } break;
    case obj_spherePylon: { return 30; } break;
    case obj_sphereMinion: { return 10; } break;
    case obj_shadowGremlin: { return 12; } break;
    case obj_hornedHapp: { return 30; } break;
    case obj_beeMinion: { return 6; } break;
    case obj_drillin: { return 3; } break;
    case obj_sweetWorm: { return 16; } break;
    case obj_sandMenace: { return 30; } break;
    case obj_hiveGrowth: { return 120;} break;
    case obj_mackerel: { return 60;} break;
    
    //Bosses
    case obj_sphereKing: {return 100+(25*floor(wave/5));} break;
    case obj_nilmerg: {return 150+waveScale(10,5,0,-1);} break;
    case obj_bombKing: {return 50+waveScale(5,1,0,-1);} break;
    case obj_bliplo: {return 300+waveScale(20,5,0,-1);} break;
    default: return 0;
}
