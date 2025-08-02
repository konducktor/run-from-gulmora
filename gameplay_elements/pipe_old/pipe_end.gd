extends Node2D

enum Direction {UP, DOWN, LEFT, RIGHT}

@export var exit_direction: Direction

@export var other_pipe : Node2D

@export var pipe_impact_velocity: float

#@export var cooldown_timer: Timer

func _on_body_entered(body: Node2D) -> void:
	print(is_instance_valid(other_pipe))
	
	if not body.is_in_group('Player') or not is_instance_valid(other_pipe): #or not cooldown_timer.is_stopped() or not other_pipe.cooldown_timer.is_stopped():
		return
	
	var target_pos = other_pipe.global_position
	var target_velocity
	
	if exit_direction == Direction.LEFT:
		target_pos = Vector2(other_pipe.global_position.x - 64, other_pipe.global_position.y)
		target_velocity = Vector2(pipe_impact_velocity * (-1.0), body.velocity.y)
	elif exit_direction == Direction.RIGHT:
		target_pos = Vector2(other_pipe.global_position.x + 64, other_pipe.global_position.y)
		target_velocity = Vector2(pipe_impact_velocity, body.velocity.y)
	elif exit_direction == Direction.UP:
		target_pos = Vector2(other_pipe.global_position.x, other_pipe.global_position.y - 64)
		target_velocity = Vector2(body.velocity.x, pipe_impact_velocity * (-1.0))
	elif exit_direction == Direction.DOWN:
		target_pos = Vector2(other_pipe.global_position.x, other_pipe.global_position.y + 64)
		target_velocity = Vector2(body.velocity.x, pipe_impact_velocity)
	
	body.global_position = target_pos
	body.velocity = target_velocity
	
	#cooldown_timer.start()
