///scr_applyWeaponStats(weapon);
//Update the player variables to accomodate the equipped weapon.
var tool_firerate,proj_spd,proj_dec,tool_spr,proj_spr,wep_Dam,wep_Knock,toolAnimation, proj_type;

//projectile types: '0' Slash. '1' Arrow

switch argument0
{    
    //Green Sword
    case ITEMID.weapon_greenSword: { toolAnimation = "STAB"; tool_firerate = 30; proj_spd = 3.5; proj_dec = 35; tool_spr = spr_swordGreen; proj_spr = hbox_sword; wep_Dam = 6; wep_Knock = 3; proj_type = 0;} break;
    
    //Dull Sword
    case ITEMID.weapon_starter: { toolAnimation = "STAB"; tool_firerate = 34; proj_spd = 3.5; proj_dec = 40; tool_spr = spr_sword; proj_spr = hbox_sword; wep_Dam = 4; wep_Knock = 3; proj_type = 0;} break;
    
    //Weak Bow
    case ITEMID.weapon_weakBow: { toolAnimation = "SHOOT"; tool_firerate = 35; proj_spd = 8; proj_dec = 0; tool_spr = spr_weakBow; proj_spr = spr_arrow; wep_Dam = 3; wep_Knock = 2; proj_type = 1;} break;
    
    case ITEMID.weapon_subLimeMachineGun: { toolAnimation = "SHOOT"; tool_firerate = 8; proj_spd = 12; proj_dec = 0; tool_spr = spr_subLimeMachineGun; proj_spr = spr_bullet; wep_Dam = 2; wep_Knock = 1; proj_type = 2;} break;
}

obj_player.toolFireRate = tool_firerate;
obj_player.projSpeed = proj_spd;
obj_player.projDecay = proj_dec;
obj_player.toolSprite = tool_spr;
obj_player.projSprite = proj_spr;
obj_player.weaponDamage = wep_Dam;
obj_player.weaponKnockback = wep_Knock;
obj_player.toolAnimation = toolAnimation;
obj_player.proj_type = proj_type;

weaponIcon = tool_spr;
