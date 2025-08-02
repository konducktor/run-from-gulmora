extends GameSounds

@export var ENTER : AudioStreamPlayer

func _on_monster_slow_zone_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	
	play_sound(ENTER)
