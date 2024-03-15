extends Control

@onready var building = get_parent().get_parent()
var recipe_data = []
var button_scene = preload("res://UI/assets/button.tscn")

func _ready():
	# For each recipe stored in the recipe dictionary on parent building, add its name to the dropdown menu
	for recipe in building.recipes:
		var button = button_scene.instantiate()
		button.text=building.recipes[recipe]["output_type"].replace("_", " ").capitalize()
		$MarginContainer/ScrollContainer/MarginContainer/VBoxContainer.add_child(button)
		recipe_data.append(building.recipes[recipe])
		button.pressed.connect(building._button_pressed.bind(button.text.replace(" ", "_").to_lower()))
