extends Area2D


func _on_body_entered(body: Node2D) -> void:
	GlobalSignals.monster_slowed.emit()


func _on_body_exited(body: Node2D) -> void:
	GlobalSignals.monster_normal.emit()
