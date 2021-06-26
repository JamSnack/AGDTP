///scr_convertToCompressedString(integer);
//Take in an integer and compress it, then return as a string.


var num = argument0;
var str = ""; //Empty string for use later

var num_str = string(num);
var num_str_length = string_length(num_str);

//---CHECK FOR NO AMT
if num == 0 then return str;

//-------------NUMBER COMPRESSION-----------------

if num >= 1000
{
    /*if num >= 1000000000000000 //One Quad
    {
        if num_str_length == 13
        {
            str += string_char_at(num_str,1);
            str += "."+string_char_at(num_str,2);
        }
        else if num_str_length == 14
        {
            str += string_char_at(num_str,1);
            str += string_char_at(num_str,2);
            str += "."+string_char_at(num_str,3);
        }
        else if num_str_length == 15
        {
            str += string_char_at(num_str,1);
            str += string_char_at(num_str,2);
            str += string_char_at(num_str,3);
            str += "."+string_char_at(num_str,4);
        }
        
        str += "Q";
    }

    else if num >= 1000000000000 //One Trill
    {
        if num_str_length == 13
        {
            str += string_char_at(num_str,1);
            str += "."+string_char_at(num_str,2);
        }
        else if num_str_length == 14
        {
            str += string_char_at(num_str,1);
            str += string_char_at(num_str,2);
            str += "."+string_char_at(num_str,3);
        }
        else if num_str_length == 15
        {
            str += string_char_at(num_str,1);
            str += string_char_at(num_str,2);
            str += string_char_at(num_str,3);
            str += "."+string_char_at(num_str,4);
        }
        
        str += "T";
    }

    else if num >= 1000000000 //One billion
    {
        if num_str_length == 10
        {
            str += string_char_at(num_str,1);
            str += "."+string_char_at(num_str,2);
        }
        else if num_str_length == 11
        {
            str += string_char_at(num_str,1);
            str += string_char_at(num_str,2);
            str += "."+string_char_at(num_str,3);
        }
        else if num_str_length == 12
        {
            str += string_char_at(num_str,1);
            str += string_char_at(num_str,2);
            str += string_char_at(num_str,3);
            str += "."+string_char_at(num_str,4);
        }
        
        str += "B";
    }
    
    else if num >= 1000000 //One million
    {
        if num_str_length == 7
        {
            str += string_char_at(num_str,1);
        }
        else if num_str_length == 8
        {
            str += string_char_at(num_str,1);
            str += string_char_at(num_str,2);
        }
        else if num_str_length == 9
        {
            str += string_char_at(num_str,1);
            str += string_char_at(num_str,2);
            str += string_char_at(num_str,3);
        }
        
        str += "M";
    }*/
    
    if num >= 1000 //One thousand
    {
        if num_str_length == 4
        {
            str += string_char_at(num_str,1);
        }
        else if num_str_length == 5
        {
            str += string_char_at(num_str,1);
            str += string_char_at(num_str,2);
        }
        else if num_str_length == 6
        {
            str += string_char_at(num_str,1);
            str += string_char_at(num_str,2);
            str += string_char_at(num_str,3);
        }
        
        str += "K";
    }
}
else
{
    str = num_str;
}

return str;
