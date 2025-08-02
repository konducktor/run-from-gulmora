extends GameSounds


@export var MONSTER_EAT : AudioStreamPlayer


func _on_monster_hit_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	
	play_sound(MONSTER_EAT)
