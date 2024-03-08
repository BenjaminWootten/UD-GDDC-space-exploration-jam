extends CharacterBody2D

const SPEED = 400.0

func _physics_process(delta):
	
	move_and_slide()
	# Get the horizontal input direction and handle the movement/deceleration.
	var horizontal = Input.get_axis("left", "right")
	if horizontal:
		velocity.x = horizontal * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
		# Get the vertical input direction and handle the movement/deceleration.
	var vertical = Input.get_axis("up", "down")
	if vertical:
		velocity.y = vertical * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
