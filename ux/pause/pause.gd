extends Control


var paused : bool

func _ready() -> void:
	set_pausing_to(false)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed('pause'):
		set_pausing_to(not paused)


func set_pausing_to(value: bool) -> void:
	paused = value
	visible = value
	get_tree().paused = value
	
	if value:
		GlobalSignals.paused.emit()
	else:
		GlobalSignals.unpaused.emit()
