extends Area2D

@onready var item_container = get_node("/root/World/items")

var items = {
	lead_bar = preload("res://items/lead_bar.tscn"),
	lead_plate = preload("res://items/lead_plate.tscn")
}

func spawn(itemName):
	var item = items[itemName].instantiate()
	item_container.add_child(item)
	item.position = global_position
