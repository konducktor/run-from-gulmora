extends Area2D

@export var other_pipe : Node2D

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group('Player') and other_pipe == null:
		return
	
	body.global_position = other_pipe.global_position
