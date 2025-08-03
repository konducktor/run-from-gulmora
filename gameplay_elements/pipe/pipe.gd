extends Node2D

enum Direction {UP, DOWN, LEFT, RIGHT}

@export var EXIT_DIRECTION: Direction

@export var OTHER_PIPE : Node2D

@export var PIPE_IMPACT_VELOCITY: float

#@export var cooldown_timer: Timer


func _on_body_entered(body: Node2D) -> void:
	if (not body.is_in_group('Player')) or (not OTHER_PIPE): #or not cooldown_timer.is_stopped() or not OTHER_PIPE.cooldown_timer.is_stopped():
		return
	
	var target_pos = OTHER_PIPE.global_position
	var target_velocity
	
	if EXIT_DIRECTION == Direction.LEFT:
		target_pos = Vector2(OTHER_PIPE.global_position.x - 64, OTHER_PIPE.global_position.y)
		target_velocity = Vector2(PIPE_IMPACT_VELOCITY * (-1.0), body.velocity.y)
	elif EXIT_DIRECTION == Direction.RIGHT:
		target_pos = Vector2(OTHER_PIPE.global_position.x + 64, OTHER_PIPE.global_position.y)
		target_velocity = Vector2(PIPE_IMPACT_VELOCITY, body.velocity.y)
	elif EXIT_DIRECTION == Direction.UP:
		target_pos = Vector2(OTHER_PIPE.global_position.x, OTHER_PIPE.global_position.y - 64)
		target_velocity = Vector2(body.velocity.x, PIPE_IMPACT_VELOCITY * (-1.0))
	elif EXIT_DIRECTION == Direction.DOWN:
		target_pos = Vector2(OTHER_PIPE.global_position.x, OTHER_PIPE.global_position.y + 64)
		target_velocity = Vector2(body.velocity.x, PIPE_IMPACT_VELOCITY)
	
	body.global_position = target_pos
	body.velocity = target_velocity
	
	#cooldown_timer.start()
