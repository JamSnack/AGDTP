/// scr_playSound(soundID, loop, priority, x, y, volume)
var soundID = argument0, loop = argument1, priority = argument2, x = argument3, y = argument4, volume = argument5;
audio_sound_gain(soundID,volume,0);
audio_play_sound_at(soundID,x,y,0,0,16*6,1,loop,priority); 
