///scr_fitText(string,size);
//This script forces a given string to be no longer than a given size (in pixels);

var str = argument0;
var size = argument1;

var str_width = string_width(str);
var new_str = "";
var string_breaks = 0;
var last_space_pos = 1;
var reset_amount = 0;

if str_width > size
{
    for (pos=1;pos<=string_length(str);pos++)
    {
        var next_letter = string_char_at(str,pos);
        
        new_str += next_letter;
        
        if next_letter == " " { last_space_pos = pos; }
        else if next_letter == "#" { reset_amount += string_length(new_str)-reset_amount; } 
        
        if string_length(new_str)-reset_amount >= size*(string_breaks+1)
        { 
            new_str = string_delete(new_str,last_space_pos,1);
            new_str = string_insert("#",new_str,last_space_pos);
            string_breaks += 1;
        }
    }
    return new_str;
}
else return str;


