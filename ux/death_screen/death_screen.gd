extends Control
class_name DeathScreen


@export var ENTER_TYPE: Tween.TransitionType = Tween.TRANS_SINE
@export var ENTER_TIME : float = 0.5

@export_group("References")
@export var METERS_LABEL : Label
@export var TIME_LABEL : Label


func setup(meters: float, seconds: float) -> void:
	METERS_LABEL.text = 'Meters: ' + str(meters)
	TIME_LABEL.text = 'Time: ' + str(int(seconds)/60) + ':' + str(fmod(seconds, 60.0))


func _ready() -> void:
	position = Vector2(0.0, 1080.0)
	create_tween().tween_property(self, 'position', Vector2.ONE, ENTER_TIME).set_trans(ENTER_TYPE)


func _on_play_again_button_pressed() -> void:
	if get_tree():
		get_tree().reload_current_scene()
