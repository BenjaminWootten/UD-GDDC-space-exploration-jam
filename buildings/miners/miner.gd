extends StaticBody2D

@onready var output = $Output

var ore_type: String

func _ready():
	await get_tree().create_timer(0.05).timeout
	var ore = $ore_detector.get_overlapping_areas()
	if ore:
		ore_type = ore[0].name
		$Timer.start()

func _on_timer_timeout():
	output.spawn(ore_type)
