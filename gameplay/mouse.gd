extends Node


func _ready() -> void:
	set_mouse_visibility(false)
	
	GlobalSignals.player_died.connect(_on_player_death)
	GlobalSignals.paused.connect(_on_paused)
	GlobalSignals.unpaused.connect(_on_unpaused)


func _on_player_death() -> void:
	set_mouse_visibility(true)

func _on_paused() -> void:
	set_mouse_visibility(true)

func _on_unpaused() -> void:
	set_mouse_visibility(false)


func set_mouse_visibility(value: bool) -> void:
	if value:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
