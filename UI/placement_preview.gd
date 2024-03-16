extends Area2D

@onready var sprite = $Sprite2D
@onready var collisionShape = $CollisionShape2D
@onready var timer = $Timer

var placing: bool
var colliders = []
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

@export var smelter_texture: CompressedTexture2D
var smelter_path = preload("res://buildings/crafters/smelter.tscn")

@export var crafter_texture: CompressedTexture2D
var crafter_path = preload("res://buildings/crafters/crafter.tscn")

@export var amalgamator_texture: CompressedTexture2D
var amalgamator_path = preload("res://buildings/crafters/amalgamator.tscn")

@export var miner_texture: CompressedTexture2D
var miner_path = preload("res://buildings/miners/miner.tscn")

@export var hitbox_2x2: RectangleShape2D
@export var hitbox_1x1: RectangleShape2D

func _process(delta):
	
	if get_overlapping_areas() or get_overlapping_bodies():
		colliders = get_overlapping_areas() + get_overlapping_bodies()
		colliding = true
		sprite.modulate = Color(1,0,0)
	else:
		colliding = false
		sprite.modulate = Color(0,1,0)
	
	if placing:
		# Move preview to mouse
		self.global_position = snapped(get_global_mouse_position(), Vector2(SNAP, SNAP))
		position += Vector2(offset, offset)
		
		# Place building
		if Input.is_action_pressed("left_click") and not colliding and timer.is_stopped():
			var placement = building_to_place.instantiate()
			placement.set("rotation", rotation)
			# Set parent either conveyor or machine groups
			if building_to_place == conveyor_path:
				conveyor_container.add_child(placement)
			else:
				building_container.add_child(placement)
			placement.position = global_position
			timer.start()
		
		# Destroy building
		if Input.is_action_pressed("right_click") and colliding and timer.is_stopped() and colliders:
			# delete all current colliders
			for collider in colliders:
			# Conveyors have placement collider as a child, so remove parent to remove whole conveyor
				if collider.name == "placement_collider":
					collider.get_parent().queue_free()
				# Or just remove object as normal for other stuff
				else:
					collider.queue_free()
				colliders.erase(collider)
			timer.start()

func placement_start(texture: CompressedTexture2D, hitbox: RectangleShape2D, newOffset: int, building: PackedScene):
	placing = true
	sprite.texture = texture
	collisionShape.shape = hitbox
	offset = newOffset
	building_to_place = building

func _on_color_rect_mouse_entered():
	placement_end()

func placement_end():
	placing = false
	sprite.texture = null
	collisionShape.shape = null

func _input(event):
	if placing:
		if event.is_action_pressed("quit_build"):
			placement_end()
		if event.is_action_pressed("rotate") and placing:
			rotation_degrees += 90

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

func _on_smelter_pressed():
	placement_start(smelter_texture,  hitbox_2x2, 16, smelter_path)
	# Temporary to account for placeholder texture size/color
	sprite.scale = Vector2(0.5,0.5)
	sprite.modulate = Color(0,1,0)

func _on_button_pressed():
	placement_start(crafter_texture,  hitbox_2x2, 16, crafter_path)
	# Temporary to account for placeholder texture size/color
	sprite.scale = Vector2(0.5,0.5)
	sprite.modulate = Color(0,1,0)

func _on_amalgamator_pressed():
	placement_start(amalgamator_texture,  hitbox_2x2, 16, amalgamator_path)
	# Temporary to account for placeholder texture size/color
	sprite.scale = Vector2(0.5,0.5)
	sprite.modulate = Color(0,1,0)

func _on_miner_pressed():
	placement_start(miner_texture,  hitbox_1x1, 0, miner_path)
	# Temporary to account for placeholder texture size/color
	sprite.scale = Vector2(0.25,0.25)
	sprite.modulate = Color(0,1,0)
