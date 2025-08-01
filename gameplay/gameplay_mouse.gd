extends Node


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	GlobalSignals.player_died.connect(_on_player_death)


func _on_player_death() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
