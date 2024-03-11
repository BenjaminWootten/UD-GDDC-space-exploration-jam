extends Area2D

@onready var item_container = get_node("/root/World/items")

var items = {
	iron = preload("res://items/iron.tscn"),
	iron_plate = preload("res://items/iron_plate.tscn")
}

func spawn(itemName):
	var item = items[itemName].instantiate()
	item_container.add_child(item)
	item.position = global_position
