extends StaticBody2D

@onready var input = $Input
@onready var output = $Output
@onready var timer = $Timer

var input_inventory = 0
var output_inventory = 0

var recipes = {
	none = {input_type = "none", input_num = 0, output_type = "none", output_num = 0, time = 0},
	iron_plate = {input_type = "iron", input_num = 1, output_type = "iron_plate", output_num = 1, time = 1},
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
