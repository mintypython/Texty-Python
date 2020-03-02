///@function texty_apply_width(texty, width)
///@arg texty
///@arg width
///@desc fits text into a width by adding newlines. Basically does what draw_text_ext does internally
var texty = argument0, width = argument1;
var text = texty[| TEXTY.text];
var len = string_length(text);
var f_list = ds_list_create();
var ss = texty[| TEXTY.stylesheet];
ds_list_add(f_list, texty_format_get_property(ss[? "default"],TEXTYFORMAT.font));
var pos = 0, lastspace = 1, lastpos = 0;

for(var i = 1; i <= len; i++){
	switch(string_char_at(text,i)){
		case "\n":
			pos = 0;
			lastspace = i;
			lastpos = 0;
			break;
		case "<":
			for(var j = i; j <= len; j++){
				if(string_char_at(text, j)==">"){
					var fmt = string_fromto(text,i+1,j-1);
					if(string_char_at(fmt,1)=="/"){
						ds_list_delete(f_list,ds_list_size(f_list)-1);
					}
					else if(ds_map_exists(ss,fmt)){
						ds_list_add(f_list,texty_format_get_property(ss[? fmt], TEXTYFORMAT.font));
					}
					i=j;
					break;
				}
			}
			break;
		case "[":
			for(var j = i; j <= len; j++){
				if(string_char_at(text, j)=="]"){
					i=j;
					break;
				}
			}
			break;
		case " ":
			lastspace = i;
			lastpos = 0;
		default:
			var fnt = f_list[| ds_list_size(f_list)-1];
			if(fnt != undefined)
				draw_set_font(fnt);
			var value = string_width(string_char_at(text,i));
			pos += value;
			lastpos += value;
			if(pos > width && lastpos != pos){
				text = string_delete(text,lastspace,1);
				text = string_insert("\n",text,lastspace);
				texty[| TEXTY.text] = text;
				pos = lastpos;
			}
	}
}

ds_list_destroy(f_list);