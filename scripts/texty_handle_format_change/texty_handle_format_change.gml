///@function texty_handle_format_change(texty)
///@arg texty
///@desc grabs the format name from <format> tags in the string
var texty = argument0;

///Trim < and >
var str = string_lower(string_replace_all(string_copy(argument1, 2, string_length(argument1)-2)," ",""));
if(string_char_at(str,1)=="/"){
	ds_list_delete(texty[| TEXTY.format_list], ds_list_size(texty[| TEXTY.format_list])-1);
	texty_format_evaluate(texty);
}
else{
	//if not, this format change only has an argument
	var stylesheet = texty[| TEXTY.stylesheet];

	if(ds_map_exists(stylesheet, str)){
		ds_list_add(texty[| TEXTY.format_list], stylesheet[? str]);
		texty_format_evaluate(texty);
	}
}