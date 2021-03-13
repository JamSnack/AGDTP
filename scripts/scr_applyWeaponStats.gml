///scr_applyWeaponStats(weapon);
//Update the player variables to accomodate the equipped weapon.
var tool_firerate,proj_spd,proj_dec,tool_spr,proj_spr,wep_Dam,wep_Knock,toolAnimation, proj_type,tool_snd;

tool_snd = noone;
var swish = choose(snd_swish1,snd_swish2,snd_swish3,snd_swish4);

//projectile types: '0' Slash. '1' Arrow. '2' Bullet

switch argument0
{    
    //Green Sword
    case ITEMID.weapon_greenSword: { toolAnimation = "STAB"; tool_firerate = 30; proj_spd = 3.5; proj_dec = 35; tool_spr = spr_swordGreen; proj_spr = hbox_sword; wep_Dam = 6; wep_Knock = 4; proj_type = 0; tool_snd = swish;} break;
    
    //Dull Sword
    case ITEMID.weapon_starter: { toolAnimation = "STAB"; tool_firerate = 34; proj_spd = 3.5; proj_dec = 40; tool_spr = spr_sword; proj_spr = hbox_sword; wep_Dam = 4; wep_Knock = 3.5; proj_type = 0; tool_snd = swish;} break;
    
    //Weak Bow
    case ITEMID.weapon_weakBow: { toolAnimation = "SHOOT"; tool_firerate = 35; proj_spd = 8; proj_dec = 0; tool_spr = spr_weakBow; proj_spr = spr_arrow; wep_Dam = 3; wep_Knock = 1; proj_type = 1;} break;
    
    case ITEMID.weapon_subLimeMachineGun: { toolAnimation = "SHOOT"; tool_firerate = 10; proj_spd = 8; proj_dec = 0; tool_spr = spr_subLimeMachineGun; proj_spr = spr_bullet; wep_Dam = 3; wep_Knock = 0.5; proj_type = 2; tool_snd = snd_machineGunSoft; } break;
    case ITEMID.weapon_sphereLauncher: { toolAnimation = "SHOOT"; tool_firerate = 45; proj_spd = 4; proj_dec = 0; tool_spr = spr_sphereLauncher; proj_spr = spr_sphere; wep_Dam = 3; wep_Knock = 2; proj_type = "SPHERE"; tool_snd = snd_sphereLaunch;} break;
    case ITEMID.weapon_beemerang: { toolAnimation = "SHOOT"; tool_firerate = 50; proj_spd = 3; proj_dec = 0; tool_spr = spr_nothing; proj_spr = spr_beemerang; wep_Dam = 4; wep_Knock = 3; proj_type = "BOOMERANG"; tool_snd = snd_swish1;} break;
    case ITEMID.weapon_acornRifle: { toolAnimation = "SHOOT"; tool_firerate = 65; proj_spd = 13; proj_dec = 0; tool_spr = spr_acornRifle; proj_spr = spr_rifleBullet; wep_Dam = 10; wep_Knock = 4; proj_type = 2; tool_snd = snd_rifle; } break;
}

//Apply tags
if hudControl.selectedSlot != noone
{
    var tagsUnloaded = hudControl.inventorySlotTags[hudControl.selectedSlot];
    
    if ds_exists(tagsUnloaded,ds_type_list)
    {
        for (i=0;i<ds_list_size(tagsUnloaded);i++)
        {
            var tag = tagsUnloaded[| i]
            
            //Tool Speed+
            if tag == "Tool Speed+" 
            { 
                tool_firerate = clamp(tool_firerate-(tool_firerate*0.20),1,100);
            }
        }
    }
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
obj_player.tool_snd = tool_snd;
