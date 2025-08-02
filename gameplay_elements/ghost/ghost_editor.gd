@tool
extends Node2D


var parent : Node2D


func _ready() -> void:
	parent = get_parent()


func _draw():
	if Engine.is_editor_hint():
		draw_circle(Vector2.ZERO, parent.ANGER_RANGE, Color.RED, false, 1.0)
		draw_circle(Vector2.ZERO, parent.PASSIVE_RANGE, Color.GREEN, false, 1.0)
