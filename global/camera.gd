extends Node2D


@export var REFERENCE_OBJECT : Node2D
@export var OFFSET : float


func _process(_delta: float) -> void:
	position = Vector2(position.x, REFERENCE_OBJECT.position.y - OFFSET)
