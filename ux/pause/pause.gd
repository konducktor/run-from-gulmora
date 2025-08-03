extends Control


var can_pause : bool
var paused : bool


func _ready() -> void:
	can_pause = true
	set_pausing_to(false)
	
	GlobalSignals.player_died.connect(_on_player_death)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed('pause'):
		set_pausing_to(not paused)


func _on_player_death():
	can_pause = false


func set_pausing_to(value: bool) -> void:
	if not can_pause:
		return
	
	paused = value
	visible = value
	get_tree().paused = value
	
	if value:
		GlobalSignals.paused.emit()
	else:
		GlobalSignals.unpaused.emit()


func _on_continue_pressed() -> void:
	set_pausing_to(false)
