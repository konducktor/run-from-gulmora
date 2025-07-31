extends Node2D
class_name Level

@export var next_level_trigger : Area2D

func _on_next_level_trigger_body_entered(body: Node2D) -> void:
	next_level_trigger.set_deferred("monitoring", false)
	#next_level_trigger_collision.disabled = true
	GlobalSignals.next_level.emit()
