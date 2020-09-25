///new_raidBoss();
//instance_create a gremlin based on wave number.
var gremNumber = irandom(100); //The number used to generate the gremlin out of 100%

//Initialize gremlin lists.
var bossGremlins;

//Add boss gremlins to the list as the wave number increases.
bossGremlins[0] = obj_bombKing;

if wave >= 15 && gremNumber >= 90 then bossGremlins[1] = obj_sphereKing;

var mobType = "NORMAL"; //Normal or Special boss.

//Select gremlin
switch mobType
{
    //-------------Select a boss-----------------
    case "NORMAL": { var i = bossGremlins[irandom(array_length_1d(bossGremlins)-1)]; }
    break;
}

var g = instance_create(choose(RAIDBOUND_Lower-16,RAIDBOUND_Upper+16),room_height/2,i);
return g;
