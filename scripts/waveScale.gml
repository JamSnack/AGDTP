///waveScale(amtPerFrequency,frequency,min,max);
//amtPerFrequency = how much you want per frequency
//frequency = How many waves equals 1 frequency.
var _dif = scr_getDifficulty();
var m = argument3;
if m == -1 then m = argument0*_dif;
return clamp(floor(argument0+(argument0*floor(_dif/argument1))),argument2,m);
