extends Node2D


@export var ANIMATION_PLAYER : AnimationPlayer


func _ready() -> void:
	ANIMATION_PLAYER.play("main")
