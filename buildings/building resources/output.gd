extends Area2D

@onready var item_container = get_node("/root/World/items")

var items = {
	lead_ore = preload("res://items/lead_ore.tscn"),
	lead_bar = preload("res://items/lead_bar.tscn"),
	lead_plate = preload("res://items/lead_plate.tscn"),
	lead_casing = preload("res://items/lead_casing.tscn"),
	lead_bullet = preload("res://items/lead_bullet.tscn"),
	coal = preload("res://items/coal.tscn"),
	coal_powder = preload("res://items/coal_powder.tscn"),
	sulfur = preload("res://items/sulfur.tscn"),
	sulfur_powder = preload("res://items/sulfur_powder.tscn"),
	gunpowder = preload("res://items/gunpowder.tscn"),
}

func spawn(itemName):
	var item = items[itemName].instantiate()
	item_container.add_child(item)
	item.position = global_position
