///scr_convertToCompressedString(integer);
//Take in an integer and add comas to make it more readable.


var num = argument0;
var str = ""; //Empty string for use later

var num_str = string(num);
var num_str_length = string_length(num_str);

//---CHECK FOR NO AMT
if num == 0 then return str;

//-------------NUMBER COMPRESSION-----------------

if num >= 1000
{
    var pos = num_str_length-2;
    var commas = (num_str_length div 3);
    str = num_str;
    
    for(i=0;i<commas;i++)
    {
        str = string_insert(",",str,pos-(3*i));
    }
    
    //Remove commas that end up at the front of the string!
    if string_char_at(str,1) == ","
    {
        str = string_delete(str,1,1);
    }
}
else
{
    str = num_str;
}

return str;
