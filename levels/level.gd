extends Node2D
class_name Level


@export var next_level_trigger : Area2D

var level_path : String


func _on_next_level_trigger_body_entered(body: Node2D) -> void:
	if not body.is_in_group('Player'):
		return
	
	generate_next_level()


func _on_next_level_trigger_area_entered(area: Area2D) -> void:
	if not area.is_in_group('Player'):
		return
	
	generate_next_level()


func generate_next_level() -> void:
	next_level_trigger.set_deferred("monitoring", false)
	GlobalSignals.next_level.emit()
	GlobalSignals.next_level_path.emit(level_path)
