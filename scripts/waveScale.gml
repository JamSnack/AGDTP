///waveScale(amtPerFrequency,frequency,min,max);
//amtPerFrequency = how much you want per frequency
//frequency = How many waves equals 1 frequency.
var m = argument3;
if m == -1 then m = argument0*wave;
return clamp(floor(argument0+(argument0*floor(wave/argument1))),argument2,m);
