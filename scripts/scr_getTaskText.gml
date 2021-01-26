///scr_getTaskText(currentTask);
//Type '0' for default variable.
var ar0 = argument0;

var str = "";

switch ar0
{
    case 0: //First task in the game.
    { str = "This is Barry. He is trying to bake a pie!#Gather 12 sticks to fuel the oven!" } break;
    case 1: //Task 2
    { str = "Press 'C' to open the crafting menu." } break;
    case 2:
    { str = "Craft 4 Packed Dirt tiles at the workbench.#Use them to build a wall!" } break;
    case 3:
    { str = "    What's this? An anomalous event!#Kill the Gremlins, they want your pie!" } break;
    case 4:
    { str = "Something strange is happening!" } break;
}

return str;
