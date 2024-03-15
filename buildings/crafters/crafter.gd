extends "res://buildings/crafters/machine.gd"

var recipes = {
	none = {input_type = "none", input_num = 0, output_type = "none", output_num = 0, time = 0},
	lead_casing = {input_type = "lead_plate", input_num = 3, output_type = "lead_casing", output_num = 2, time = 5},
}

func _button_pressed(recipeName):
	update_recipe(recipeName, recipes)
	$CanvasLayer/recipe_select.visible=false
