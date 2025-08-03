extends Node2D


@export var ANIMATED_SPRITE : AnimatedSprite2D


func _on_spring_activated() -> void:
	ANIMATED_SPRITE.stop()
	ANIMATED_SPRITE.play("up")
	
	await ANIMATED_SPRITE.animation_finished
	
	ANIMATED_SPRITE.play('down')
