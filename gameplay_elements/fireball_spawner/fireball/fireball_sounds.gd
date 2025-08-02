extends GameSounds

@export var DEATH : AudioStreamPlayer


func _on_danger_body_entered(body: Node2D) -> void:
	play_sound(DEATH)
