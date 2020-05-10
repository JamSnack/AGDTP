///isConnected();
if position_meeting(x-16,y,OBSTA) || position_meeting(x+16,y,OBSTA)
|| position_meeting(x,y-16,OBSTA) || position_meeting(x,y+16,OBSTA)
|| position_meeting(x-16,y,PLR_NOCOL) || position_meeting(x+16,y,PLR_NOCOL)
|| position_meeting(x,y-16,PLR_NOCOL) || position_meeting(x,y+16,PLR_NOCOL)
{ return true; } else return false;
