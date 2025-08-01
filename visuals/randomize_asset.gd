extends Sprite2D

@export var ASSETS : Array[Texture2D]

func _ready() -> void:
	var random_generator = RandomNumberGenerator.new()
	texture = ASSETS[random_generator.randi_range(0, len(ASSETS)-1)]
