extends GameSounds
class_name PlayerSounds


@export var JUMP : AudioStreamPlayer
@export var WALKING : AudioStreamPlayer


func _on_player_jumped() -> void:
	play_sound(JUMP, random_pitch())
	stop_sound(WALKING)


func _on_player_falling() -> void:
	pass


func _on_player_walking() -> void:
	play_sound(WALKING, random_pitch())
	


func _on_player_idle() -> void:
	stop_sound(WALKING)
