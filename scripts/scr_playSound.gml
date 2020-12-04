/// scr_playSound(soundID, loop, priority, xx, yy, volume)
var soundID = argument0, loop = argument1, priority = argument2, xx = argument3, yy = argument4, volume = argument5;
audio_sound_gain(soundID,volume,0);
audio_play_sound_at(soundID,xx,yy,0,0,16*6,1,loop,priority); 
