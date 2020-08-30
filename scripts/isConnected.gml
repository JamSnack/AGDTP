///isConnected(x,y);
var xx = argument0;
var yy = argument1;
if position_meeting(xx-16,yy,OBSTA) || position_meeting(xx+16,yy,OBSTA)
|| position_meeting(xx,yy-16,OBSTA) || position_meeting(xx,yy+16,OBSTA)
|| position_meeting(xx-16,yy,PLR_NOCOL) || position_meeting(xx+16,yy,PLR_NOCOL)
|| position_meeting(xx,yy-16,PLR_NOCOL) || position_meeting(xx,yy+16,PLR_NOCOL)
{ return true; } else return false;
