extends GameSounds

@export var ACTIVATED : AudioStreamPlayer


func _on_spring_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	
	play_sound(ACTIVATED, random_pitch())
