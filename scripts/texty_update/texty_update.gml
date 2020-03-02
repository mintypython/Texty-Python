///@function texty_update(texty)
///@arg texty
///@return whether or not the texty has finished typing
///@desc Updates a Texty Python object, typing out letters and evaluating commands

/*
	By default, Texty Python text writes out like a typewriter. Call this function every step to update
	the text at the speed defined by the current format.
*/
var texty = argument0;

if(!ds_exists(texty,ds_type_list)) return true;
if(texty[| TEXTY.current_character] <= string_length(texty[| TEXTY.text])) {
	if(texty[| TEXTY.pause]>0){
		texty[| TEXTY.pause]--;
		return false;
	}
	
	var oldchar = texty[| TEXTY.current_character];
	texty[| TEXTY.current_character] += texty_format_get_property(texty[| TEXTY.current_format], TEXTYFORMAT.text_speed);

	/*
		Evaluate special commands
	*/
	
	//Check for new character
	if((floor(texty[| TEXTY.current_character]) != floor(oldchar)) && !texty[| TEXTY.escape]){
		
		//Newline or special command
		switch(string_char_at(texty[| TEXTY.text], texty[| TEXTY.current_character])){
			case "\n":
				texty_new_group(texty, true);
				break;
			//Escape character
			case "\\":
				texty[| TEXTY.escape] = true;
				break;
			//Color Changes
			case "<":
				while(string_char_at(texty[| TEXTY.text], texty[| TEXTY.current_character]) == "<"){
					for(var i = floor(texty[| TEXTY.current_character]); i <= string_length(texty[| TEXTY.text]); i++){
							if(string_char_at(texty[| TEXTY.text], i) == ">"){
								texty_new_group(texty, false);
								texty_handle_format_change(texty,string_fromto(texty[| TEXTY.text], floor(texty[| TEXTY.current_character]), i));
								texty[| TEXTY.group_begin] = i+1;
								texty[| TEXTY.current_character] = i;
								break;
							}
					}
				}
				break;
			case ".":
			case "!":
			case "?":
				if(!texty_lastchar(texty))
					texty[| TEXTY.pause] = 8/texty_format_get_property(texty[| TEXTY.current_format], TEXTYFORMAT.text_speed);
				break;
			case ",":
				texty[| TEXTY.pause] = 5/texty_format_get_property(texty[| TEXTY.current_format], TEXTYFORMAT.text_speed);
				break;
		}
	}
	texty[| TEXTY.escape] = false;
	return false;
}
return true;