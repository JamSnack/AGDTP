///scr_useConsumable(item);
//Return the object associated with the itemID of the tile to place.
var item = argument0;


toolReady = false;
armIndex = spr_armSwing;
armAngleGoal = 71;
armAngle = 70; //Straight up
armAngleRate = 0;
toolSprite = spr_copperOre;
alarm[2] = room_speed;

switch item
{

    // Gremlin Talisman
    case 14:
    {   
        if interm == false then exit;
        
        worldControl.world_Time = 0;
        scr_raidControl("RAID",0,0,0,0); // Preset Raid
        toolReady = false;
        armIndex = spr_armSwing;
        armAngleGoal = 71;
        armAngle = 70; //Straight up
        armAngleRate = 0;
        toolSprite = spr_gremBlock;
        alarm[2] = room_speed;
    }
    break;
    
    //Bomb
    case 17:
    {
        var bomb = instance_create(obj_player.x,obj_player.y,obj_bomb);
        
        bomb.speed = 6;
        bomb.direction = point_direction(x,y,mouse_x,mouse_y);
        bomb.gravity = grav;
    
        toolReady = false;
        armIndex = spr_armSwing;
        armAngleGoal = 51;
        armAngle = 50; //Out a bit
        armAngleRate = 0;
        toolSprite = spr_itemDrops;
        alarm[2] = room_speed/2;
    }
    break;
}

scr_invenRemoveItem(item,1,4,false,hudControl.selectedSlot,noone);
