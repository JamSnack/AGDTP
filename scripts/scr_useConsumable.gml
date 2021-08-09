/// scr_useConsumable(item)
///scr_useConsumable(item);
//Return the object associated with the itemID of the tile to place.
var item = argument0;

/*
toolReady = false;
armIndex = sprite_arm_swing;
armAngleGoal = 71;
armAngle = 70; //Straight up
armAngleRate = 0;
toolSprite = spr_copperOre;
alarm[2] = room_speed;
*/

switch item
{

    // Gremlin Talisman
    case 14:
    {   
        armIndex = sprite_arm_swing;
        armAngleGoal = 71;
        armAngle = 70; //Straight up
        armAngleRate = 0;
        toolSprite = spr_gremBlock;
        alarm[2] = room_speed;

        if interm == false then exit;
        
        scr_raidControl(nextRaid,0,0,0,0); // Preset Raid
    }
    break;
    
    //Bomb
    case 17:
    {
        var bomb = instance_create(obj_player.x,obj_player.y,obj_bomb);
        
        bomb.speed = 6;
        bomb.direction = point_direction(x,y,mouse_x,mouse_y);
    
        armIndex = sprite_arm_swing;
        armAngleGoal = 51;
        armAngle = 50; //Out a bit
        armAngleRate = 0;
        toolSprite = spr_itemDrops; //hold nothing
        alarm[2] = room_speed;
    }
    break;
    
    case ITEMID.cons_treeFruit:
    {
        if toolReady == true
        {
            armIndex = sprite_arm_swing;
            armAngleGoal = 51;
            armAngle = 50; //Out a bit
            armAngleRate = 0;
            toolSprite = spr_itemDrops; //hold nothing
            alarm[2] = 20;
        }
    
        var _hp = obj_player.hp;
        var _maxHp = obj_player.maxHp;
        
        if _hp < _maxHp
        {
            obj_player.hp = approach(_hp,_maxHp,10);
            
            audio_play_sound(snd_heal,8,false);
            scr_popMessage("+10",global.fnt_menu,1,c_green,x-4,y);
        }
        else if _hp >= _maxHp
        {
            audio_play_sound(snd_invalid,12,false);
            scr_popMessage("HP full",global.fnt_menu,1,c_red,x-8,y);
            exit;
        }
    }
    break;
}
//Slot is non-specific due to quick heal using this script :)
scr_invenRemoveItem(item,1,4,false,-1,noone);
