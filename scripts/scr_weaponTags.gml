///scr_weaponTags(tagType,weaponSlot);
//Apply tag effects for weapons.

/*--Tag Types--
    > "STAT"
        - Adjusts weapon/tool stats such as toolFireRate.
    > "PROJECTILE"
        - Adjusts projectile specific stats such as damage, projDecay, projSpeed, projType.
*/
var tagsUnloaded = hudControl.inventorySlotTags[argument1];

for (i=0;i<ds_list_size(tagsUnloaded);i++)
{
    switch argument0
    {
        case "PROJECTILE":
        {
            switch tagsUnloaded[| i]
            {
                //Increases projectile speed
                case "Fast": { spd += 1; sprite = spr_gremBlock; } break;
            }
        }
        break;
    }
}

