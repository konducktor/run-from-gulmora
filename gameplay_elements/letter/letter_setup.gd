extends Node2D


@export var level_generator : LevelGenerator


func _ready() -> void:
	GlobalSignals.letter_collected.connect(_on_letter_colleted)


func _on_letter_colleted() -> void:
	GlobalValues.letter_count += 1
	
	if GlobalValues.letter_count == 4:
		level_generator.generate_final_level()
