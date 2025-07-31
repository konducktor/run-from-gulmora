extends Node2D


@export var required_letters : int = 4

@export var level_generator : LevelGenerator


func _ready() -> void:
	GlobalValues.letter_count = 0
	GlobalSignals.letter_collected.connect(_on_letter_colleted)


func _on_letter_colleted() -> void:
	GlobalValues.letter_count += 1
	
	if GlobalValues.letter_count == required_letters:
		level_generator.generate_final_level()
