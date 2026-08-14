extends Area2D
class_name JetpackItem




func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	
	#var player := body as Player
	
	GlobalSignals.jetpack_picked_up.emit()
	queue_free()
