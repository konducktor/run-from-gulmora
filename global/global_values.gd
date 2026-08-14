extends Node


enum PlayerType {
	REGULAR, JETPACK
}

var current_player_type: PlayerType

var letter_count : int
var is_tutorial_finished : bool
var is_generating_letter_levels : bool


func _ready() -> void:
	Engine.time_scale = 1.0
	current_player_type = PlayerType.REGULAR
	
	GlobalSignals.jetpack_picked_up.connect(_on_jetpack_picked_up)
	GlobalSignals.jetpack_finished.connect(_on_jetpack_finished)


func _on_jetpack_picked_up() -> void:
	current_player_type = PlayerType.JETPACK


func _on_jetpack_finished() -> void:
	current_player_type = PlayerType.REGULAR


func freeze_time(time_scale: float = 0.01, duration: float = 0.3) -> void:
	var prev_time_scale = Engine.time_scale
	
	Engine.time_scale = time_scale
	await get_tree().create_timer(duration, true, false, true).timeout
	Engine.time_scale = prev_time_scale
