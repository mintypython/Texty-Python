///@function texty_format_new()
///@desc creates a new format block for texty to use
enum TEXTYFORMAT {
	font, //can change font
	color, //can change color
	text_speed, //can change typing speed
	animation //can add animations
}

enum TEXTYANIM {
	bounce, //bouncing letters
	rainbow //color changing text
}

var format = ds_map_create();
return format;