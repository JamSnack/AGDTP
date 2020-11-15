///waveScale(amtPerFrequency,frequency,min,max);
var m = argument3;
if m == -1 then m = argument0*wave;
return clamp(floor(argument0+(argument0*floor(wave/argument1))),argument2,m);
