extends Control

@onready var building = get_parent().get_parent()
var recipe_data = []

func _ready():
	# For each recipe stored in the recipe dictionary on parent building, add its name to the dropdown menu
	for recipe in building.recipes:
		var button = Button.new()
		button.text=building.recipes[recipe]["output_type"].replace("_", " ").capitalize()
		$MarginContainer/ScrollContainer/MarginContainer/VBoxContainer.add_child(button)
		recipe_data.append(building.recipes[recipe])


