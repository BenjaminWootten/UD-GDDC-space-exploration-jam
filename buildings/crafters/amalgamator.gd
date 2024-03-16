extends "res://buildings/crafters/machine.gd"

var recipes = {
	none = {input_type = "none", input_num = 0, input2_type = "none", input2_num = 0, output_type = "none", output_num = 0, time = 0},
	gunpowder = {input_type = "coal_powder", input_num = 2, input2_type = "sulfur_powder", input2_num = 1, output_type = "gunpowder", output_num = 3, time = 5},
	lead_bullet = {input_type = "gunpowder", input_num = 2, input2_type = "lead_casing", input2_num = 1, output_type = "lead_bullet", output_num = 1, time = 8},
}

func _button_pressed(recipeName):
	update_recipe(recipeName, recipes)
	$CanvasLayer/recipe_select.visible=false
