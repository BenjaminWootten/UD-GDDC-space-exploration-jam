extends Area2D

@onready var sprite = $Sprite2D
@onready var collisionShape = $CollisionShape2D

var placing: bool
var building_to_place
var colliding = false
var offset = 0
var entered_bodies = 0
const SNAP = 32

@onready var conveyor_container = get_node("/root/World/conveyors")
@onready var building_container = get_node("/root/World/machines")

@export var crusher_texture: CompressedTexture2D
var crusher_path = preload("res://buildings/crafters/crusher.tscn")
@export var conveyor_texture: CompressedTexture2D
var conveyor_path = preload("res://buildings/conveyors/conveyor.tscn")

@export var hitbox_2x2: RectangleShape2D
@export var hitbox_1x1: RectangleShape2D

func _process(delta):
	if placing:
		self.global_position = snapped(get_global_mouse_position(), Vector2(SNAP, SNAP))
		position += Vector2(offset, offset)
		
		if Input.is_action_pressed("left_click") and not colliding:
			var placement = building_to_place.instantiate()
			if building_to_place == conveyor_path:
				conveyor_container.add_child(placement)
			else:
				building_container.add_child(placement)
			placement.position = global_position
			placement.rotation = global_rotation

func placement_start(texture: CompressedTexture2D, hitbox: RectangleShape2D, newOffset: int, building: PackedScene):
	placing = true
	sprite.texture = texture
	collisionShape.shape = hitbox
	offset = newOffset
	building_to_place = building

func placement_end():
	placing = false
	sprite.texture = null
	collisionShape.shape = null

func _input(event):
	if placing:
		if event.is_action_pressed("quit_build"):
			placement_end()
		if event.is_action_pressed("rotate"):
			rotation_degrees += 90

func _on_body_entered(_body):
	entered_bodies += 1
	colliding = true
	sprite.modulate = Color(1,0,0)

func _on_body_exited(_body):
	entered_bodies -= 1
	if entered_bodies == 0:
		colliding = false
		sprite.modulate = Color(0,1,0)

func _on_conveyor_pressed():
	placement_start(conveyor_texture, hitbox_1x1, 0, conveyor_path)
	# Temporary to account for placeholder texture size/color
	sprite.scale = Vector2(0.25,0.25)
	sprite.modulate = Color(0,0.5,0)

func _on_crusher_pressed():
	placement_start(crusher_texture,  hitbox_2x2, 16, crusher_path)
	# Temporary to account for placeholder texture size/color
	sprite.scale = Vector2(0.5,0.5)
	sprite.modulate = Color(0,1,0)
