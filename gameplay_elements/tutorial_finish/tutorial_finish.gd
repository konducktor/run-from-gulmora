extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group('Player'):
		return
	
	set_deferred('monitoring', false)
	
	GlobalValues.is_tutorial_finished = true
	GlobalSignals.tutorial_finished.emit()
