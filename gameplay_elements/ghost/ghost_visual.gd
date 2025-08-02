extends Node2D


@export var SPRITE_ROTATION_SPEED = 0.3

@export_group("References")
@export var ACTIVE_STATE : GhostStateActive
@export var SPRITE : Sprite2D


func _process(_delta: float) -> void:
	if not ACTIVE_STATE.self_state_current:
		SPRITE.rotation_degrees = 0.0
		return
	
	SPRITE.rotation = move_toward(SPRITE.rotation, ACTIVE_STATE.velocity.angle() + PI, SPRITE_ROTATION_SPEED)
