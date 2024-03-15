extends StaticBody2D

@onready var input = $Input
@onready var output = $Output
@onready var timer = $Timer

var input_inventory = 0
var output_inventory = 0

var recipe

func update_recipe(newRecipe, recipes):
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
