///scr_hurt(damage,time,knockback,knockAmt,direction);
var damage = argument0; //Damage dealt
var time = argument1; //Time until it can be hurt again.
var knock = argument2; //Whether or not to apply knockback.
var knockAmt = argument3; // How much knockback to be applied.
var dir = argument4; // Direction

 //knockback conditions
if object_get_parent(object_index) == TILE || object_get_parent(object_index) == PLRTILE  || object_get_parent(object_index) == PLT_1 || object_get_parent(object_index) == PLR_NOCOL
    { knock = false; damage = round(damage/10)+1 }

//Enemy death event.
if (hp-damage <= 0) && other.object_index == obj_projectile && (object_get_parent(object_index) == GR_ENEMY || object_get_parent(object_index) == ENEMY)
{
    //ENEMY DEATH TAGS
    var _ran = irandom(100);
    var tagsUnloaded = hudControl.inventorySlotTags[hudControl.selectedSlot];
    
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

if canHurt == false then exit; //Don't hurt unhurtable objects :)
canHurt = false;
alarm[hurtAlarm] = time;
hp -= damage;

if knock == true
{
    var otherX = other.x;
    var otherY = other.y;

    //add Force equal to the knockAmt* 1 or -1, depending on whether or not the source instance is to the left or the right of the hurt instance.
    hForce += knockAmt*(sign(x-otherX));
    vForce += knockAmt*(sign(y-otherY));
    knockBack = true;
    
    if knockType == "LAND"
    {
        if place_meeting(x+hForce,y,OBSTA)
        {
            hForce = 0;
        }
        
        if place_meeting(x,y+vForce,OBSTA)
        {
            vForce = 0;
        }
    }
}

//--Display pop message--
var c;
if object_index == obj_player then c = c_red else c = c_yellow;
scr_popMessage(string(damage),global.fnt_Ui,0.4,c,x,y);
