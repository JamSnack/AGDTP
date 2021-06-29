///scr_musicTransition(soundid,time);
var time = argument1;

audio_sound_gain(music,0,time);
music = audio_play_sound(argument0,20,true);
audio_sound_gain(music,0,0);
audio_sound_gain(music,(hudControl.musicToggled)*music_volume,time);
