extends Level
class_name FinalLevel


@export var CREDITS_SCENE : PackedScene


func _on_finish_trigger_body_entered(body: Node2D) -> void:
	if not body.is_in_group('Player'):
		return
	
	GlobalSignals.final_level_reached.emit()


func _on_credits_trigger_body_entered(body: Node2D) -> void:
	if not body.is_in_group('Player'):
		return
	
	get_tree().call_deferred('change_scene_to_packed', CREDITS_SCENE)
