extends StaticBody2D

@onready var input = $Input
@onready var output = $Output
@onready var timer = $Timer

var input_inventory = 0
var output_inventory = 0

var recipes = {
	none = {input_type = "none", input_num = 0, output_type = "none", output_num = 0, time = 0},
	lead_plate = {input_type = "lead_bar", input_num = 2, output_type = "lead_plate", output_num = 3, time = 3},
	coal_powder = {input_type = "coal", input_num = 1, output_type = "coal_powder", output_num = 2, time = 2},
	sulfur_powder = {input_type = "sulfur", input_num = 1, output_type = "sulfur_powder", output_num = 1, time = 2},
}

var recipe = recipes["none"]

func _ready():
	update_recipe("iron_plate")

func update_recipe(newRecipe):
	recipe = recipes[newRecipe]
	input.input_type = recipe["input_type"]
	timer.wait_time = recipe["time"]

func _on_input_updated():
	if input_inventory >= recipe["input_num"] and timer.is_stopped():
		input_inventory -= recipe["input_num"]
		timer.start()

func _on_timer_timeout():
	_on_input_updated()
	output_inventory += recipe["output_num"]
	output.spawn(recipe["output_type"])

func _on_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("left_click"):
		$CanvasLayer/recipe_select.visible=true

func _button_pressed(a):
	print(a)
	$CanvasLayer/recipe_select.visible=false
