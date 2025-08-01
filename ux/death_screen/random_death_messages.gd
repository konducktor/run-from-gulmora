extends Label

@export var PHRASES : Array[String]

func _ready() -> void:
	var random_generator = RandomNumberGenerator.new()
	text = PHRASES[random_generator.randi_range(0, len(PHRASES)-1)]
