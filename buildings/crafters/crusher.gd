extends "res://buildings/crafters/machine.gd"

var recipes = {
	none = {input_type = "none", input_num = 0, output_type = "none", output_num = 0, time = 0},
	lead_plate = {input_type = "lead_bar", input_num = 2, output_type = "lead_plate", output_num = 3, time = 3},
	coal_powder = {input_type = "coal", input_num = 1, output_type = "coal_powder", output_num = 2, time = 2},
	sulfur_powder = {input_type = "sulfur", input_num = 1, output_type = "sulfur_powder", output_num = 1, time = 2},
}

func _button_pressed(recipeName):
	update_recipe(recipeName, recipes)
	$CanvasLayer/recipe_select.visible=false
