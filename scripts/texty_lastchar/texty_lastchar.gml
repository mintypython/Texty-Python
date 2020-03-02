///@function texty_lastchar(text)
///@arg texty
///@desc returns whether or not we're typing the last letter (don't pause on the last letter)
var char=floor(argument0[| TEXTY.current_character]);
var text=argument0[| TEXTY.text];
var len = string_length(text);
if(char>=len){
	return true;
}
char++;
while(string_char_at(text,char)=="<"){
	while(string_char_at(text,++char)!=">" && char<len){}
	
}
return char>=len;