extends GameSounds

@export var PIPE : AudioStreamPlayer

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player") or not is_instance_valid(self.get_parent().other_pipe):
		return
	
	play_sound(PIPE, random_pitch())
