///@function texty_format_default()
///@desc creates a new format block for texty to use
var format = ds_map_create();
texty_format_set_property(format, TEXTYFORMAT.font,			fnt_default); //controls font
texty_format_set_property(format, TEXTYFORMAT.color,		c_white); //controls color
texty_format_set_property(format, TEXTYFORMAT.text_speed,	0.5); //controls typing speed
return format;