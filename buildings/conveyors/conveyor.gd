extends Area2D

@export var MOVE_SPEED = Vector2(200, 200)

var direction = Vector2.ZERO
var bodies = []

func _ready():
	var _rotation = round(global_rotation_degrees)
	if _rotation == 0:
		direction = Vector2(0, -1)
	elif _rotation == 180 or _rotation == -180:
		direction = Vector2(0, 1)
	elif _rotation == 90:
		direction = Vector2(1, 0)
	elif _rotation == 270 or _rotation == -90:
		direction = Vector2(-1, 0)

func _physics_process(delta):
	# Handle player conveyor behavior
	var i = 0
	for body in bodies:
		if body.name == "Player":
			var directional_velocity = body.velocity * direction
			# Check if directional veloctiy is below move speed in each direction to prevent bursts of speed when transitioning between conveyors
			# Check if directional velocity is greater than 0 to allow backwards movement on conveyors
			if directional_velocity.x < MOVE_SPEED.x and directional_velocity.y < MOVE_SPEED.y and directional_velocity.x >= 0 and directional_velocity.y >= 0:
				body.velocity += direction * MOVE_SPEED
		else:
			if i < 1:
				body.linear_velocity = direction * MOVE_SPEED
			i += 1

func _on_body_entered(body):
	bodies.append(body)
	if body.name != "Player":
		body.add_conveyor()

func _on_body_exited(body):
	bodies.erase(body)
	if body.name != "Player":
		body.linear_velocity = Vector2.ZERO
		body.subtract_conveyor()
