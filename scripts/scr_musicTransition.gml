///scr_musicTransition(soundid,time);
audio_sound_gain(music,0,1);
if audio_exists(music) then audio_stop_sound(music);

music = audio_play_sound(argument0,10,true);
audio_sound_gain(music,1,argument1);
