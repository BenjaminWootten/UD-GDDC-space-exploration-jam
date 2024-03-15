extends RigidBody2D

var conveyors = 0

@export var item_type: String

func add_conveyor():
	conveyors += 1

func subtract_conveyor():
	conveyors -= 1
	if conveyors <= 0:
		queue_free()
