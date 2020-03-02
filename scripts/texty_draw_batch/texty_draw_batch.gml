///@arg texty_draw_batch(text,format,x,y)
///@arg text
///@arg format
///@arg x
///@arg y

/*
	Draws a batch of text. Formatting rules and animations are applied here
*/
var text=argument0,format=argument1,xx=argument2,yy=argument3;
draw_set_halign(fa_left);

//apply formatting rules
if(ds_map_exists(format, TEXTYFORMAT.color)) draw_set_color(texty_format_get_property(format, TEXTYFORMAT.color));
if(ds_map_exists(format, TEXTYFORMAT.font)) draw_set_font(texty_format_get_property(format, TEXTYFORMAT.font));

//animate the text if using an animation
if(ds_map_exists(format, TEXTYFORMAT.animation)){
	switch(format[? TEXTYFORMAT.animation]){
		case TEXTYANIM.bounce:
			for(var i = 1; i <= string_length(text); i++){
				var char = string_char_at(text,i);
				var y2 = yy - abs(sin(get_timer()/150000 + i*0.2))*string_height("M")*0.3;
				draw_text(xx, y2, char);
				xx+=string_width(char);
			}
			break;
		case TEXTYANIM.rainbow:
			for(var i = 1; i <= string_length(text); i++){
				var char = string_char_at(text,i);
				draw_set_color(make_color_hsv((get_timer()/2000 + i*20)%255,255,255));
				draw_text(xx, yy, char);
				xx+=string_width(char);
			}
			break;
	}
}
else{
	draw_text(xx, yy, text);
}