///scr_fitText(string,size);
//This script forces a given string to be no longer than a given size (in pixels);

var str = argument0;
var size = argument1;

var str_width = string_width(str);
var new_str = "";
var string_breaks = 0;

if str_width > size
{
    for (pos=0;pos<string_length(str);pos++)
    {
        new_str += string_char_at(str,pos);
        
        if string_length(new_str) >= size*(string_breaks+1)
        { 
            new_str += "#";
            string_breaks += 1;
        }
    }
}

return new_str;
