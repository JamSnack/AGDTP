///scr_popUiCreate(x,y,targetX,targetY,sizeX,sizeY,targetObject,type);
var i = instance_create(argument0,argument1,obj_popUi);
i.targX = argument2;
i.targY = argument3;
i.targSizeX = argument4;
i.targSizeY = argument5;
i.targetObject = argument6; //The object that calls the script. (noone if no arrow will be drawn.)
i.type = argument7; //What the Ui will contian.

return i;
