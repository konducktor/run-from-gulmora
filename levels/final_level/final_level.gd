extends Level
class_name FinalLevel


@export var CREDITS_SCENE : PackedScene
@export var link: String


func _on_finish_trigger_body_entered(body: Node2D) -> void:
	if not body.is_in_group('Player'):
		return
	
	GlobalSignals.final_level_reached.emit()


func _on_credits_trigger_body_entered(body: Node2D) -> void:
	if not body.is_in_group('Player'):
		return
	
	OS.shell_open(link)
	
	#get_tree().call_deferred('change_scene_to_packed', CREDITS_SCENE)
