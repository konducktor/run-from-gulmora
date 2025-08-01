extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group('Player'):
		return
	
	set_deferred('monitoring', false)
	GlobalSignals.tutorial_finished.emit()
