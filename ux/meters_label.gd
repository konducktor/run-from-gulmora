extends Label


@export var PLAYER : Node2D


var meters_offset

var meters:
	set(value):
		var clamped_value = clamp((-value + meters_offset) * 0.003, 0, INF)
		meters = snapped(clamped_value, 0.01)
		
		text = "Meters: " + str(meters)


func _ready() -> void:
	meters_offset = PLAYER.position.y + 1.9

func _process(_delta: float) -> void:
	meters = PLAYER.position.y
