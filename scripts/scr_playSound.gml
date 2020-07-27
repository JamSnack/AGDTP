///scr_playSound(emitterID,soundID,loop,priority);
var emitterID = argument0;
var snd = argument1;

if audio_emitter_exists(emitterID)
{ 
    if !audio_exists(snd) 
    { 
        audio_play_sound_on(emitterID,snd,argument2,argument3); 
    } 
}
