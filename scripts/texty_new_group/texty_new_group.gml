///@function texty_new_group(texty, newline)
///@arg texty
///@arg newline
///@desc creates a new group of text for formatted blocks

enum TEXTYGROUP {
	text,
	formatting,
	newline,
	width,
	height
}

var texty = argument0;
var group = ds_list_create();
var format = ds_map_create();
ds_map_copy(format, texty[| TEXTY.current_format]);
group[| TEXTYGROUP.text] = string_fromto(texty[| TEXTY.text], texty[| TEXTY.group_begin], floor(texty[| TEXTY.current_character]-1));
group[| TEXTYGROUP.formatting] = format;
ds_list_mark_as_map(group, TEXTYGROUP.formatting);
group[| TEXTYGROUP.newline] = argument1;

var fnt = texty_format_get_property(format, TEXTYFORMAT.font);
if(fnt != undefined) draw_set_font(fnt);
group[| TEXTYGROUP.width] = string_width(group[| TEXTYGROUP.text]);
group[| TEXTYGROUP.height] = string_height(group[| TEXTYGROUP.text]);

ds_list_add_list(texty[| TEXTY.groups], group);

texty[| TEXTY.group_begin] = floor(texty[| TEXTY.current_character])+1;