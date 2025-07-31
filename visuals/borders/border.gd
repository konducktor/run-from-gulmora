extends Area2D

@export var TRANSITION_TIME : float = 0.3
@export var sprite : Sprite2D


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group('Player'):
		return
		
	var tween = create_tween()
	tween.tween_property(sprite, 'modulate', Color(Color.WHITE, 0.5), TRANSITION_TIME)


func _on_body_exited(body: Node2D) -> void:
	if not body.is_in_group('Player'):
		return
		
	var tween = create_tween()
	tween.tween_property(sprite, 'modulate', Color(Color.WHITE, 1), TRANSITION_TIME)
