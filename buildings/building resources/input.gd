extends Area2D

@onready var machine = get_parent()
var input_type
signal input_updated

func _ready():
	input_updated.connect(machine._on_input_updated)

func _on_body_entered(body):
	if body.get_meta("item_type") == input_type:
		machine.input_inventory += 1
		input_updated.emit()
		body.queue_free()
