extends Control


@export var GAME_VALUES : GameValues

@export var METERS_LABEL : Label
@export var TIME_LABEL : Label


func _process(_delta: float) -> void:
	METERS_LABEL.text = 'Meters: ' + str(GAME_VALUES.meters)
	TIME_LABEL.text = 'Time: ' + str(int(GAME_VALUES.time)/60) + ':' + str(fmod(GAME_VALUES.time, 60.0))
