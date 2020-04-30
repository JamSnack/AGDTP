///scr_getTaskText(currentTask,elementGoal,waveElement,itemElement);
//Type '0' for default variable.
var currentTask = argument0;
var elementGoal = argument1;
var itemElement = argument2;

var str;

switch currentTask
{
    case 0: //First task in the game.
    { str = "Explore the world!#Break trees and#collect 30 sticks!# " } break;
    case 1: //Task 2
    { str = "Press 'C' to open# the crafting menu!" } break;
    case 2:
    { str = "Craft and place#a workbench." } break;
    case 3:
    { str = "Craft 8 Packed Dirt#tiles!" } break;
    case 4:
    { str = "Dig underground!#Mine 2 Copper Ore.#" } break;
    case 5:
    { str = "Survive for 5 waves!#" } break;
    case 6: { str = "The demo has been#completed. Thanks for#playing!" } break;
}

return str;
