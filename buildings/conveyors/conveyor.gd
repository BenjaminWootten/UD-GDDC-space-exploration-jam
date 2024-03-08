extends Area2D

const MOVE_SPEED = Vector2(200, 200)

var direction = Vector2.ZERO
var bodies = []

func _ready():
	if global_rotation_degrees == 0:
		direction = Vector2(0, -1)
	elif global_rotation_degrees == 180:
		direction = Vector2(0, 1)
	if global_rotation_degrees == 90:
		direction = Vector2(1, 0)
	if global_rotation_degrees == 270:
		direction = Vector2(-1, 0)

func _physics_process(delta):
	for body in bodies:
		body.velocity += direction * MOVE_SPEED

func _on_body_entered(body):
	bodies.append(body)
	body.set_collision_layer_value(1, false)

func _on_body_exited(body):
	bodies.erase(body)
	body.set_collision_layer_value(1, true)
