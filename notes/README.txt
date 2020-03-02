GETTING STARTED:
	-Before drawing the text, you must create a texty object using texty_create or texty_create_width.
	-You then have the option of letting it type itself out like a typewriter using texty_update in a step event, or writing it out instantly
	using texty_skip
	-Finally, in a draw event, call texty_draw to actually draw your text

FORMATS:
	-Relevant folder: Format
	-A format defines the rules of how your text should be drawn. This controls things like color, animation, and typing speed
	-Check out the script texty_format_default for an example of what a format looks like

STYLESHEETS:
	-Relevant folder: Stylesheet
	-A stylesheet is a collection of available formats. All stylesheets must have a format named "default", which serves
	as the format that texty_draw will use from the beginning.
	-Check out texty_stylesheet_default for an example of what a stylesheet looks like

FAQ:

Q:	What exactly is a "texty"?
A:	A "texty" is a ds_map that holds all of the information about your text, like the actual text to draw, what formats it can use,
	how much of it has already been typed out, and all the different batches of text. One would call it a "pseudo object" since it
	acts like an object.
	
Q:	What is a "batch"?
A:	A "batch" is a chunk of text that has the same formatting. A texty is divided into batches of text so that you can draw large
	chunks of it instead of individually calling draw_text on each letter

Q:	How do I make my text fit in a certain width like draw_text_ext?
A:	Create the texty with texty_create_width, or call texty_apply_width after creating your texty with texty_create.
	Define the width you want it to be, and it'll stay within that space.

Q:	Does texty_draw work with draw_set_halign and draw_set_valign?
A:	Yep! It'll shift the text to correctly align itself with the current alignment values.

Q:	Why can I only make my text red, and not any other color?
A:	You can make the text any color you like, you just need to add a format for it. Formats are designed to be more robust than just
	a color change, so only a couple of example formats are included. Check out texty_stylesheet_default for those formats.

Q:	How do I add more format properties, like changing size?
A:	You need to visit two places. texty_format_new contains the properties enum, you can add a new one to the enum there
	texty_draw_batch handles format changes. Look for the "apply formatting rules" comment

Q:	Where do I add new animations?
A:	Same place as where you add new format properties. texty_format_new has an animations enum, and texty_draw_batch
	handles animations. Look for the "animate the text" comment
	
Q:	Do I need to destroy custom stylesheets and formats to prevent memory leaks?
A:	No, you don't. As long as they were added to a texty pseudo object, they will be cleaned up automatically when
	the texty is destroyed. You DO need to clean up your texty with texty_destroy though