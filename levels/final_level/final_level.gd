extends Level
class_name FinalLevel


func _on_finish_trigger_body_entered(body: Node2D) -> void:
	if not body.is_in_group('Player'):
		return
	
	GlobalSignals.final_level_reached.emit()
