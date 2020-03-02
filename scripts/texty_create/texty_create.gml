///@function texty_create(text, ?stylesheet)
///@arg text
///@arg ?stylesheet

/*
Creates the texty pseudo-object, and defines its properties using an enum
You can pass in a custom stylesheet. If you don't, the default stylesheet will be used.
*/

enum TEXTY {
	text,
	groups,
	current_format,
	format_list,
	stylesheet,
	group_begin,
	current_character,
	pause,
	escape
}

var texty = ds_list_create();
texty[| TEXTY.text] = argument[0];
texty[| TEXTY.groups] = ds_list_create();
ds_list_mark_as_list(texty, TEXTY.groups);
texty[| TEXTY.current_format] = ds_map_create();
ds_list_mark_as_map(texty, TEXTY.current_format);
texty[| TEXTY.format_list] = ds_list_create();
ds_list_mark_as_list(texty, TEXTY.format_list);
var stylesheet;
if(argument_count > 1){
	stylesheet = argument[1];
}else{
	stylesheet = texty_stylesheet_default();
}
texty[| TEXTY.stylesheet] = stylesheet;
ds_list_mark_as_map(texty, TEXTY.stylesheet);
ds_list_add(texty[| TEXTY.format_list], stylesheet[? "default"]);
texty_format_evaluate(texty);
texty[| TEXTY.group_begin] = 1;
texty[| TEXTY.current_character] = 0;
texty[| TEXTY.pause] = 0;
texty[| TEXTY.escape] = false;
return texty;