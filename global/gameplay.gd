extends Node2D


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed('restart'):
			if get_tree():
				get_tree().call_deferred('reload_current_scene')
