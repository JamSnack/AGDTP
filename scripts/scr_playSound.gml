///scr_playSound(emitterID,soundID,loop,priority,x,y);
var emitterID = argument0;
var snd = argument1;

if audio_emitter_exists(emitterID)
{ 
    //print('Sound Played');

    //UPDATE AUDIO Position
    audio_emitter_position(emitterID,argument4,argument5,0);
    audio_play_sound_on(emitterID,snd,argument2,argument3); 
}
