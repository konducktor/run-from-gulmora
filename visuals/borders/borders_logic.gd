extends Node

@export var player : Player
@export var right_border : Area2D
@export var left_border : Area2D

func _physics_process(_delta: float) -> void:
	right_border.position.y = player.position.y
	left_border.position.y = player.position.y
