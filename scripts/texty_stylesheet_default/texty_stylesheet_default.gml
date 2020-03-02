var stylesheet = texty_stylesheet_new();
texty_stylesheet_add_format(stylesheet, "default", texty_format_default());

var format;

#region red color format
format = texty_format_new();
texty_format_set_property(format, TEXTYFORMAT.color, c_red);
texty_stylesheet_add_format(stylesheet, "red", format);
#endregion

#region bounce animation format
format = texty_format_new();
texty_format_set_property(format, TEXTYFORMAT.animation, TEXTYANIM.bounce);
texty_stylesheet_add_format(stylesheet, "bounce", format);
#endregion

return stylesheet;