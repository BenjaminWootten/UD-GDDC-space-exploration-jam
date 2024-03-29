extends Area2D

@onready var machine = get_parent()
var input_type
var input2_type
signal input_updated

func _ready():
	input_updated.connect(machine._on_input_updated)

func _on_body_entered(body):
	if body.item_type == input_type:
		machine.input_inventory += 1
		input_updated.emit()
		body.queue_free()
	if input2_type:
		if body.item_type == input2_type:
			machine.input2_inventory += 1
			input_updated.emit()
			body.queue_free()
