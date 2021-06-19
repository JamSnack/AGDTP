///scr_applyWeaponStats(weapon);
//Update the player variables to accomodate the equipped weapon.
var proj_spd,proj_dec,tool_spr,proj_spr,toolAnimation, proj_type,tool_snd;

tool_snd = noone;
var swish = choose(snd_swish1,snd_swish2,snd_swish3,snd_swish4);

//projectile types: '0' Slash. '1' Arrow. '2' Bullet

var item_id = argument0;


// Apply weapon animation variables and projectile stats

switch item_id
{    
    case ITEMID.weapon_greenSword: { toolAnimation = "STAB"; proj_spd = 3.5; proj_dec = 35; tool_spr = spr_swordGreen; proj_spr = hbox_sword; proj_type = 0; tool_snd = swish;} break;
    case ITEMID.weapon_starter: { toolAnimation = "STAB"; proj_spd = 3.5; proj_dec = 40; tool_spr = spr_sword; proj_spr = hbox_sword; proj_type = 0; tool_snd = swish;} break;
    case ITEMID.weapon_weakBow: { toolAnimation = "SHOOT"; proj_spd = 8; proj_dec = 0; tool_spr = spr_weakBow; proj_spr = spr_arrow; proj_type = 1;} break; 
    case ITEMID.weapon_subLimeMachineGun: { toolAnimation = "SHOOT"; proj_spd = 8; proj_dec = 0; tool_spr = spr_subLimeMachineGun; proj_spr = spr_bullet; proj_type = 2; tool_snd = snd_machineGunSoft; } break;
    case ITEMID.weapon_sphereLauncher: { toolAnimation = "SHOOT"; proj_spd = 4; proj_dec = 0; tool_spr = spr_sphereLauncher; proj_spr = spr_sphere; proj_type = "SPHERE"; tool_snd = snd_sphereLaunch;} break;
    case ITEMID.weapon_beemerang: { toolAnimation = "SHOOT"; proj_spd = 3; proj_dec = 0; tool_spr = spr_nothing; proj_spr = spr_beemerang; proj_type = "BOOMERANG"; tool_snd = snd_swish1;} break;
    case ITEMID.weapon_acornRifle: { toolAnimation = "SHOOT"; proj_spd = 13; proj_dec = 0; tool_spr = spr_acornRifle; proj_spr = spr_rifleBullet; proj_type = 2; tool_snd = snd_rifle; } break;
    case ITEMID.weapon_waterGun: { toolAnimation = "SHOOT"; proj_spd = 9; proj_dec = 0; tool_spr = spr_waterGun; proj_spr = spr_waterBlast; proj_type = 2; tool_snd = snd_rifle; } break;
    case ITEMID.weapon_seashellSpear: { toolAnimation = "STAB"; proj_spd = 0; proj_dec = 35; tool_spr = spr_seashellSpear; proj_spr = hbox_sword; proj_type = 0; tool_snd = swish;} break;
}



//Apply Weapon stats

scr_getToolStats(item_id);


obj_player.toolFireRate = toolFireRate;
obj_player.projSpeed = proj_spd;
obj_player.projDecay = proj_dec;
obj_player.toolSprite = tool_spr;
obj_player.projSprite = proj_spr;
obj_player.weaponDamage = weaponDamage;
obj_player.weaponKnockback = weaponKnockback;
obj_player.toolAnimation = toolAnimation;
obj_player.proj_type = proj_type;
obj_player.tool_snd = tool_snd;
