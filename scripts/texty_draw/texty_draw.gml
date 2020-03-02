///@function texty_draw(texty, x, y)
///@arg texty
///@arg x
///@arg y

/*
	Draws the texty at the given position
*/

var texty = argument0;
if(!ds_exists(texty,ds_type_list)) return;
var text = texty[| TEXTY.text], groups = texty[| TEXTY.groups];

var xx = 0;
var yy = 0;

var anim_x = 0;
var anim_y = 0;

var hmult;
switch(draw_get_halign()){
	case fa_center: hmult = 0.5; break;
	case fa_right: hmult = 1; break;
	case fa_left: default: hmult = 0; break;
}

var vmult;
switch(draw_get_valign()){
	case fa_middle: vmult = 0.5; break;
	case fa_bottom: vmult = 1; break;
	case fa_top: default: vmult = 0; break;
}

var cur_string = string_fromto(text, texty[| TEXTY.group_begin], texty[| TEXTY.current_character]);
var fnt = texty_format_get_property(texty[| TEXTY.current_format], TEXTYFORMAT.font);
if(fnt != undefined) draw_set_font(fnt);
var w = string_width(cur_string);

var lastline = true;
for(var i=0;i < ds_list_size(groups);i++){
	var grp = groups[| i];
	if(lastline) xx -= grp[| TEXTYGROUP.width]*hmult;
	if(grp[| TEXTYGROUP.newline]) { lastline = false; yy -= grp[| TEXTYGROUP.height]*vmult; }
}
if(lastline) xx -= w*hmult;

//Draw grouped text
for(var i = 0; i < ds_list_size(groups); i++){
	var current_group = groups[| i];
	texty_draw_batch(current_group[| TEXTYGROUP.text],current_group[| TEXTYGROUP.formatting],argument1 + xx,argument2 + yy);
	xx += string_width(current_group[| TEXTYGROUP.text]);
	if(current_group[| TEXTYGROUP.newline]){
		xx = 0;
		yy += string_height("M");
		
		lastline = true;
		for(var j=i+1;j < ds_list_size(groups);j++){
			var grp = groups[| j];
			xx -= grp[| TEXTYGROUP.width]*hmult;
			if(grp[| TEXTYGROUP.newline]){ lastline = false; break; }
		}
		if(lastline) xx -= w*hmult;
	}
}

//Draw non-grouped text
texty_draw_batch(cur_string,texty[| TEXTY.current_format],argument1 + xx,argument2 + yy);