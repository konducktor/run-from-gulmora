extends Area2D
class_name Danger

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group('Player'):
		return
	
	GlobalSignals.player_died.emit()


func _on_area_entered(area):
	if not area is DashBubble:
		return
	
	GlobalSignals.player_died.emit()
