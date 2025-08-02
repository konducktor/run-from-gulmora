extends GameSounds

@export var DEATH : AudioStreamPlayer

func _on_danger_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	
	play_sound(DEATH, random_pitch())
