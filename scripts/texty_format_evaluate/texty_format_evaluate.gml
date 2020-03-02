var texty = argument0;
ds_map_clear(texty[| TEXTY.current_format]);

for(var i = 0; i < ds_list_size(texty[| TEXTY.format_list]); i++){
	var fmt = ds_list_find_value(texty[| TEXTY.format_list], i);
	for(var key = ds_map_find_first(fmt); key != undefined; key = ds_map_find_next(fmt, key)){
		if(ds_map_exists(fmt, key)) ds_map_set(texty[| TEXTY.current_format], key, fmt[? key]);
	}
}