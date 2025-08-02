extends Node
class_name GameValues


@export var PLAYER : Node2D


var is_capturing : bool

var meters_offset : float
var time_real : float

var meters : float:
	set(value):
		var clamped_value = clamp((-value + meters_offset) * 0.003, 0, INF)
		meters = snapped(clamped_value, 0.01)

var time : int:
	set(value):
		time = snapped(value, 1)


func _ready() -> void:
	is_capturing = true
	
	meters_offset = PLAYER.position.y + 1.9
	GlobalSignals.player_died.connect(_on_player_death)


func _process(delta: float) -> void:
	if not is_capturing:
		return
	
	time_real += delta
	
	time = time_real
	meters = PLAYER.position.y

func _on_player_death():
	is_capturing = false
