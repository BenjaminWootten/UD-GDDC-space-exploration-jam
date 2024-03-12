extends Control

@onready var building = get_parent().get_parent()
@export var dropdown: OptionButton

var recipe_data = []

func _ready():
	# For each recipe stored in the recipe dictionary on parent building, add its name to the dropdown menu
	for recipe in building.recipes:
		dropdown.add_item(building.recipes[recipe]["output_type"].replace("_", " ").capitalize())
		recipe_data.append(building.recipes[recipe])

func _on_option_button_item_selected(index):
	building.update_recipe()
