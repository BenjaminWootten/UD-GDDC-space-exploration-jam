extends StaticBody2D

@onready var input = $Input
var input2: Area2D
@onready var output = $Output
@onready var timer = $Timer

var input_inventory = 0
var input2_inventory = 0
var second_input_inventory = 0
var output_inventory = 0

var recipe

func _ready():
	if get_node_or_null("Input2"):
		input2 = $Input2

func update_recipe(newRecipe, recipes):
	recipe = recipes[newRecipe]
	input.input_type = recipe["input_type"]
	if input2:
		input2.input_type = recipe["input_type"]
		input.input2_type = recipe["input2_type"]
		input2.input2_type = recipe["input2_type"]
	if recipe["time"] > 0:
		timer.wait_time = recipe["time"]

func _on_input_updated():
	if input2:
		if input_inventory >= recipe["input_num"] and input2_inventory >= recipe["input2_num"] and timer.is_stopped():
			input_inventory -= recipe["input_num"]
			input2_inventory -= recipe["input2_num"]
			timer.start()
	else:
		if input_inventory >= recipe["input_num"] and timer.is_stopped():
			input_inventory -= recipe["input_num"]
			timer.start()

func _on_timer_timeout():
	_on_input_updated()
	output_inventory += recipe["output_num"]
	while output_inventory > 0:
		output.spawn(recipe["output_type"])
		output_inventory -= 1

func _on_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("left_click"):
		$CanvasLayer/recipe_select.visible=true
