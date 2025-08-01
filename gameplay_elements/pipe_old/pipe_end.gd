extends Node2D

enum Direction {UP, DOWN, LEFT, RIGHT}

@export var exit_direction: Direction

@export var other_pipe : Node2D

func _on_body_entered(body: Node2D) -> void:
	print(is_instance_valid(other_pipe))
	
	if not body.is_in_group('Player') or !is_instance_valid(other_pipe):
		return
	
	var target_pos = other_pipe.global_position
	
	if exit_direction == Direction.LEFT:
		target_pos = Vector2(other_pipe.global_position.x - 64, other_pipe.global_position.y)
	elif exit_direction == Direction.RIGHT:
		target_pos = Vector2(other_pipe.global_position.x + 64, other_pipe.global_position.y)
	elif exit_direction == Direction.UP:
		target_pos = Vector2(other_pipe.global_position.x, other_pipe.global_position.y - 64)
	elif exit_direction == Direction.DOWN:
		target_pos = Vector2(other_pipe.global_position.x, other_pipe.global_position.y + 64)
	
	body.global_position = target_pos
