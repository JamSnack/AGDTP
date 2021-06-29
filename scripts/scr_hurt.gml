///scr_hurt(damage,time,knockback,knockAmt);
if gameOver == true then exit;

var damage = argument0; //Damage dealt
var time = argument1; //Time until it can be hurt again.
var knock = argument2; //Whether or not to apply knockback.
var knockAmt = argument3; // How much knockback to be applied.

//Protect chests from abuse
var other_index = other.object_index;
var other_parent = object_get_parent(other_index);
var inst_parent = object_get_parent(object_index);

if (object_index == obj_chest && ( other_parent == GR_ENEMY || other_parent == ENEMY )) then exit;

//player sound
if object_index == obj_player
{
    if audio_exists(snd_player_hurt)
    {
        audio_stop_sound(snd_player_hurt);
    }

    audio_play_sound(snd_player_hurt,9,false);
    audio_sound_pitch(snd_player_hurt,choose(0.9,1,1.1));
}

 //Tile conditions
if inst_parent == TILE || inst_parent == PLRTILE  || inst_parent == PLT_1 || inst_parent == PLR_NOCOL
{ 
    knock = false; 
    damage = floor(damage/6)+1;
}

//DEATH
if (hp-damage <= 0)
{
    //Death to enemies
    if (inst_parent == GR_ENEMY || inst_parent == ENEMY)
    {
        if (shield_charges <= 0 || other_index == obj_railgunBullet)
        {
            if other_index == obj_projectile
            {
                //ENEMY DEATH TAGS
                var _ran = irandom(100);
                var tagsUnloaded = other.tags;
                
                if ds_exists(tagsUnloaded,ds_type_list)
                {
                    for (i=0;i<ds_list_size(tagsUnloaded);i++)
                    {
                        var tag = tagsUnloaded[| i]
                        
                        //Grenade
                        if tag == "Grenade" 
                        { 
                            //Tie chance to this in the future.
                           var _gre = instance_create(x,y,obj_grenade);
                           _gre.damage = damage/2;
                        }
                    }
                }
            }
            
            dropItem = true;
            instance_destroy();
        }
        else
        {
            shield_health -= damage;
            
            if shield_health <= 0
            {
                shield_charges -= 1;
                shield_health = shield_health_max;
                scr_playSound(snd_shield_destroyed,false,8,x,y,1,true);
            }
        }
    }
    //Destroy tiles immediately
    else if (inst_parent == PLRTILE || inst_parent == TILE) && object_index != obj_pie
    {
        itemDrop = false;
        instance_destroy();
    }
}

if time > 0
{
    if canHurt == false then exit; //Don't hurt unhurtable objects :)
    canHurt = false;
    alarm[hurtAlarm] = time;
}

//-------DAMAGE------------
if (shield_charges <= 0 || other_index == obj_railgunBullet)
{
    hp -= damage;
    
    
    //--Display damage number--
    var c;
    if object_index == obj_player then c = c_red else c = c_yellow;
    scr_popMessage(string(damage),global.fnt_Ui,0.4,c,x+random(2),y+random(2));
    
    
    //-------KNOCKBACK-----------
    if knock == true && knockType != noone
    {
        var other_hspeed = other.hspeed;
        var other_vspeed = other.vspeed;
    
        //add Force equal to the knockAmt* 1 or -1, depending on whether or not the source instance is to the left or the right of the hurt instance.
        
        //if we have a projectile, like a sword, that has no hspeed
        if other_hspeed == 0 && other_vspeed == 0
        {
            //Correct for sprite origin
            var otherX = other.x;
            var otherY = other.y
            
            var h_correction = otherX+lengthdir_x(other.sprite_width/2,point_direction(x,y,otherX,otherY));
            var v_correction = otherY+lengthdir_y(other.sprite_height/2,point_direction(x,y,otherX,otherY));
        
            var _direction = point_direction(h_correction,v_correction,otherX,otherY);
            
            //Apply corrections
            other_hspeed = lengthdir_x(knockAmt,_direction);
            other_vspeed = lengthdir_y(knockAmt,_direction);
        }
        
        //Add knockback if the object's knockback resistance isn't greater than force!
        
        //- horizontal knockback
        var h_amt = knockAmt*sign(other_hspeed);
        
        if knock_resistance < abs(h_amt)
        {
            hForce += h_amt;
        }
        
        //- vertical knockback
        var v_amt = knockAmt*sign(other_vspeed);
        
        if knock_resistance < abs(v_amt)
        {
            if knockType == "LAND" then v_amt = -abs(v_amt);
            vForce += v_amt;
        }
    }
}
else
{
    shield_health -= damage;
    
    if shield_health <= 0
    {
        shield_charges -= 1;
        shield_health = shield_health_max;
        scr_playSound(snd_shield_destroyed,false,8,x,y,1,true);
    }
}
