extends Node

var letter_count : int
var is_tutorial_finished : bool

func freeze_time(time_scale: float = 0.007, duration: float = 0.3) -> void:
	var prev_time_scale = Engine.time_scale
	
	Engine.time_scale = time_scale
	await get_tree().create_timer(duration, true, false, true).timeout
	Engine.time_scale = prev_time_scale
