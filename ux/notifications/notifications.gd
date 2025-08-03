extends Control


signal notified


@export var MAIN_LABEL : Label
@export var ANIMATION : AnimationPlayer
@export var SOUNDS : NotificationSounds

var letters_collected : int
var laps : int


func _ready() -> void:
	letters_collected = 0
	laps = 0
	
	GlobalSignals.tutorial_finished.connect(_on_tutorial_finished)
	GlobalSignals.new_layer_reached.connect(_on_new_layer_reached)
	GlobalSignals.new_lap_started.connect(_on_new_lap_started)
	GlobalSignals.letter_collected.connect(_on_letter_collected)


func _on_tutorial_finished() -> void:
	SOUNDS.monster()
	notify("GULMORA IS AFTER YOU.")

func _on_new_layer_reached(_layer: int) -> void:
	notify("New layer reached!")



func _on_new_lap_started() -> void:
	var texts = [
		'Gulmora is Angry..',
		'Gulmora is VERY ANGRY',
		'GULMORA IS FURIOUS',
	]
	
	SOUNDS.monster()
	notify(texts[min(laps, len(texts)-1)])
	laps += 1

func _on_letter_collected() -> void:
	var texts = [
		'L _ _ _',
		'L O _ _',
		'L O O _',
		'L O O P',
	]
	
	notify(texts[min(letters_collected, len(texts)-1)])
	letters_collected += 1


func notify(text: String) -> void:
	MAIN_LABEL.text = text
	
	notified.emit()
	ANIMATION.play('notification')
