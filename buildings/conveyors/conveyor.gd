extends Area2D

const MOVE_SPEED = Vector2(200, 200)

var direction = Vector2.ZERO
var bodies = []

func _ready():
	var rotation = round(global_rotation_degrees)
	if rotation == 0:
		direction = Vector2(0, -1)
	elif rotation == 180:
		direction = Vector2(0, 1)
	elif rotation == 90:
		direction = Vector2(1, 0)
	elif rotation == 270 or rotation == -90:
		direction = Vector2(-1, 0)

func _physics_process(delta):
	for body in bodies:
		if body.name == "Player":
			var directional_velocity = body.velocity * direction
			# Check if directional veloctiy is below move speed in each direction to prevent bursts of speed when transitioning between conveyors
			# Check if directional velocity is greater than 0 to allow backwards movement on conveyors
			if directional_velocity.x < MOVE_SPEED.x and directional_velocity.y < MOVE_SPEED.y and directional_velocity.x >= 0 and directional_velocity.y >= 0:
				body.velocity += direction * MOVE_SPEED
		elif body.linear_velocity != direction * MOVE_SPEED:
			body.linear_velocity = direction * MOVE_SPEED

func _on_body_entered(body):
	bodies.append(body)

func _on_body_exited(body):
	bodies.erase(body)
