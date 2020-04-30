///inChunk();
if position_meeting(x-16,y,PLRTILE) || position_meeting(x+16,y,PLRTILE)
|| position_meeting(x,y-16,PLRTILE) || position_meeting(x,y+16,PLRTILE)
{ return true; } else return false;
