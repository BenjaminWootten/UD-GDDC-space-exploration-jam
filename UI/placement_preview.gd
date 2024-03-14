extends Area2D

@onready var sprite = $Sprite2D
@onready var hitbox = $CollisionShape2D

var placing: bool
var colliding: bool
var offset = 0
const SNAP = 32

@export var crusher_texture: CompressedTexture2D
@export var conveyor_texture: CompressedTexture2D

@export var hitbox_2x2: RectangleShape2D
@export var hitbox_1x1: RectangleShape2D

func _process(delta):
	if placing:
		self.global_position = snapped(get_global_mouse_position(), Vector2(SNAP, SNAP))
		position += Vector2(offset, offset)


func _on_conveyor_pressed():
	placing = true
	sprite.texture = conveyor_texture
	hitbox.shape = hitbox_1x1
	offset = 0
	# Temporary to account for placeholder texture size/color
	sprite.scale = Vector2(0.25,0.25)
	sprite.modulate = Color(0,0.5,0)

func _on_crusher_pressed():
	placing = true
	sprite.texture = crusher_texture
	hitbox.shape = hitbox_2x2
	offset = 16
	# Temporary to account for placeholder texture size/color
	sprite.scale = Vector2(0.5,0.5)
	sprite.modulate = Color(0,1,0)
