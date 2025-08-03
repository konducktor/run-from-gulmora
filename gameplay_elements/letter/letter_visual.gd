extends Node2D


@export var ANIMATION_PLAYER : AnimationPlayer
@export var BACKDROP : AnimatedSprite2D


func _on_letter_collected() -> void:
	ANIMATION_PLAYER.play('collected')
	await ANIMATION_PLAYER.animation_finished
	
	GlobalSignals.letter_collected.emit()
