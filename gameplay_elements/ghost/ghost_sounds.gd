extends GameSounds


@export var ATTACK : AudioStreamPlayer
@export var DEATH : AudioStreamPlayer


func _on_danger_body_entered(_body: Node2D) -> void:
	play_sound(DEATH)


func _on_active_entered() -> void:
	play_sound(ATTACK, random_pitch())
