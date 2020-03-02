///@function texty_destroy(texty)
///@arg texty

/*
	Destroys the texy to prevent memory leaks. A texty should be treated like any data structure,
	meaning you should destroy it when you're done using it
*/
if(ds_exists(argument0, ds_type_list))
	ds_list_destroy(argument0);