extends GameSounds

@export var DEATH : AudioStreamPlayer


func _on_danger_body_entered(_body: Node2D) -> void:
	play_sound(DEATH)
