extends Node2D


@export var player_respawn_timer : Timer

func _ready() -> void:
	GlobalSignals.player_died.connect(_on_player_death)

func _on_player_death() -> void:
	player_respawn_timer.start()
	await player_respawn_timer.timeout
	
	if get_tree():
		get_tree().reload_current_scene()
