extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	
	GlobalSignals.monster_slowed.emit()


func _on_body_exited(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	
	GlobalSignals.monster_normal.emit()
