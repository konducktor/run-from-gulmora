extends GameSounds


@export var COLLECT : AudioStreamPlayer


func _on_letter_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	
	play_sound(COLLECT, random_pitch())
