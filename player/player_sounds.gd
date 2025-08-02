extends GameSounds
class_name PlayerSounds


@export var JUMP : AudioStreamPlayer
@export var WALKING : AudioStreamPlayer
@export var FALL : AudioStreamPlayer

var walking : bool


func _process(_delta: float) -> void:
	if walking:
		play_sound(WALKING, random_pitch())


func _on_player_jumped() -> void:
	play_sound(JUMP, random_pitch())
	walking = false


func _on_player_falling() -> void:
	pass


func _on_player_walking() -> void:
	walking = true



func _on_player_idle() -> void:
	walking = false


func _on_player_fall() -> void:
	play_sound(FALL, random_pitch())
