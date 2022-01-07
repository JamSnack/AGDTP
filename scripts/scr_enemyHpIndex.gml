///scr_enemyHpIndex(enemy_object);
//Return the tile's base HP.
var _hp = 0;

switch argument0
{
    case obj_gremlin: { _hp = 8; } break;
    case obj_crab: { _hp = 16; } break;
    case obj_crabKing: { _hp = 225; } break;
    case obj_stoneGremlin: { _hp = 32; } break;
    case obj_grassGremlin: { _hp = 24; } break;
    case obj_spherePylon: { _hp = 30; } break;
    case obj_sphereMinion: { _hp = 10; } break;
    case obj_shadowGremlin: { _hp = 12; } break;
    case obj_hornedHapp: { _hp = 30; } break;
    case obj_beeMinion: { _hp = 6; } break;
    case obj_drillin: { _hp = 3; } break;
    case obj_sweetWorm: { _hp = 16; } break;
    case obj_sandMenace: { _hp = 30; } break;
    case obj_hiveGrowth: { _hp = 120;} break;
    case obj_mackerel: { _hp = 60;} break;
    case obj_builder_bloom: {_hp = 25;} break;
    case obj_lemon: {_hp = 85;} break;
    case obj_blueberryGremlin: {_hp = 20;} break;
    
    //Bosses
    case obj_sphereKing: {_hp = 100+(25*floor(wave/5));} break;
    case obj_nilmerg: {_hp = 150+waveScale(10,5,0,-1);} break;
    case obj_bombKing: {_hp = 50+waveScale(5,1,0,-1);} break;
    case obj_bliplo: {_hp = 300+waveScale(20,5,0,-1);} break;
    case obj_melonster: {_hp = 250+waveScale(25,5,0,-1); } break;
    default: _hp = 0;
}


//Raid Boss hp buff (+50% HP);
if worldControl.raidBossID == id
{
    _hp += round(_hp/2);
}

return _hp;
