extends Area2D

@export var STRING_STRENGTH : float

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group('Player'):
		return
	
	body.velocity.y = STRING_STRENGTH * (-1.0)
