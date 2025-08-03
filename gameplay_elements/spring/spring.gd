extends Area2D


signal activated


@export var STRING_STRENGTH : float
@export var PLAYER_START_OFFSET : Vector2


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group('Player'):
		return
	
	body.reset_extra_jumps()
	body.disable_release()
	
	body.position += PLAYER_START_OFFSET
	body.velocity.y = STRING_STRENGTH * (-1.0)
	
	body.jumped.emit()
	activated.emit()
