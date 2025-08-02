extends Control
class_name DeathScreen


@export var ENTER_TYPE: Tween.TransitionType = Tween.TRANS_SINE
@export var ENTER_TIME : float = 0.5


@export_group("References")
@export var GAME_VALUES : GameValues
@export var START_TIMER : Timer
@export var SOUNDS : GameSounds
@export var METERS_LABEL : Label
@export var TIME_LABEL : Label


func setup(meters: float, seconds: int) -> void:
	METERS_LABEL.text = 'Height: ' + str(meters) + 'm'
	
	@warning_ignore("integer_division")
	TIME_LABEL.text = 'Time: ' + str(seconds/60) + ':' + str(seconds % 60)



func _ready() -> void:
	visible = false
	GlobalSignals.player_died.connect(_on_player_death)


func _on_player_death():
	START_TIMER.start()
	await START_TIMER.timeout
	
	visible = true

	METERS_LABEL.text = 'Meters: ' + str(GAME_VALUES.meters)
	@warning_ignore("integer_division")
	TIME_LABEL.text = 'Time: ' + str(int(GAME_VALUES.time)/60) + ':' + str(fmod(GAME_VALUES.time, 60.0))
	
	SOUNDS.poopoo()
	
	position = Vector2(0.0, 1080.0)
	create_tween().tween_property(self, 'position', Vector2.ONE, ENTER_TIME).set_trans(ENTER_TYPE)


func _on_play_again_button_pressed() -> void:
	if get_tree():
		get_tree().reload_current_scene()
