extends Node2D
class_name Level


@export var next_level_trigger : Area2D


func _on_next_level_trigger_body_entered(body: Node2D) -> void:
	if not body.is_in_group('Player'):
		return
	
	next_level_trigger.set_deferred("monitoring", false)
	GlobalSignals.next_level.emit()
