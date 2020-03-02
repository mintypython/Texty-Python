//create a custom default format
my_default_format = texty_format_default();
texty_format_set_property(my_default_format, TEXTYFORMAT.color, c_aqua); //I want to write in blue by default

//create a custom stylesheet using my default format
my_stylesheet = texty_stylesheet_new();
texty_stylesheet_add_format(my_stylesheet, "default", my_default_format); //Naming my format "default" makes it the starting format

//make a texty using my stylesheet
example_text = texty_create("This text uses a custom stylesheet!", my_stylesheet);