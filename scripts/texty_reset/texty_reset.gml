///@function texty_reset(texty)
///@arg texty

/*
	Deletes the texty's typewriter progress to let it type out again
*/

var texty = argument0;
ds_list_clear(texty[| TEXTY.groups]);
ds_map_clear(texty[| TEXTY.current_format]);
ds_list_clear(texty[| TEXTY.format_list]);
var ss = texty[| TEXTY.stylesheet];
ds_list_add(texty[| TEXTY.format_list], ss[? "default"]);
texty_format_evaluate(texty);
texty[| TEXTY.group_begin] = 1;
texty[| TEXTY.current_character] = 0;
texty[| TEXTY.pause] = 0;
texty[| TEXTY.escape] = false;