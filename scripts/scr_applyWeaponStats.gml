///scr_applyWeaponStats(weapon);
//Update the player variables to accomodate the equipped weapon.
var tool_firerate,proj_spd,proj_dec,tool_spr,proj_spr,wep_Dam,wep_Knock,toolAnimation, proj_type;

//projectile types: '0' Slash. '1' Arrow

switch argument0
{    
    //Green Sword
    case 2: { toolAnimation = "SWING"; tool_firerate = 35; proj_spd = 3.5; proj_dec = 0.25; tool_spr = spr_swordGreen; proj_spr = spr_projectile1; wep_Dam = 6; wep_Knock = 3; proj_type = 0;} break;
    
    //Dull Sword
    case 3: { toolAnimation = "SWING"; tool_firerate = 40; proj_spd = 3.5; proj_dec = 0.25; tool_spr = spr_sword; proj_spr = spr_projectile1; wep_Dam = 4; wep_Knock = 3; proj_type = 0;} break;
    
    //Weak Bow
    case 11: { toolAnimation = "SHOOT"; tool_firerate = 35; proj_spd = 8; proj_dec = 0; tool_spr = spr_weakBow; proj_spr = spr_arrow; wep_Dam = 3; wep_Knock = 2; proj_type = 1;} break;
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
