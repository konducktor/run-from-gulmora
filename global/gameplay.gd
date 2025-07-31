extends Node2D


@export var player_respawn_timer : Timer

@export var meters_label: Label

func _ready() -> void:
	GlobalSignals.player_died.connect(_on_player_death)
	GlobalSignals.meters_updated.connect(_on_meters_updated)

func _on_meters_updated(value: float) -> void:
	meters_label.text = "Meters: " + str(value)

func _on_player_death() -> void:
	player_respawn_timer.start()
	await player_respawn_timer.timeout
	
	if get_tree():
		get_tree().reload_current_scene()
