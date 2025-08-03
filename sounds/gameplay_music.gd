extends Node


@export var SOUNDTRACKS : Array[AudioStream]
@export var TRANSITION_TIME : float

@export var PLAYER_1 : AudioStreamPlayer
@export var PLAYER_2 : AudioStreamPlayer

var active_player : AudioStreamPlayer
var inactive_player : AudioStreamPlayer

func _ready() -> void:
	active_player = PLAYER_1
	inactive_player = PLAYER_2
	
	active_player.volume_linear = 0.0
	active_player.play()
	
	var tween = create_tween()
	tween.tween_property(active_player, 'volume_linear', 1.0, TRANSITION_TIME)
	
	GlobalSignals.new_layer_reached.connect(_on_new_layer_reached)
	GlobalSignals.final_level_reached.connect(_on_final_level_reached)


func _on_new_layer_reached(layer_idx: int) -> void:
	update_current_soundtrack(layer_idx)


func _on_final_level_reached() -> void:
	var tween = create_tween()
	tween.tween_property(active_player, 'volume_linear', 0.0, TRANSITION_TIME)
	
	active_player.stop()


func update_current_soundtrack(idx:int) -> void:
	inactive_player.volume_linear = 0.0
	inactive_player.stream = SOUNDTRACKS[idx]
	inactive_player.play()
	
	var active_tween = create_tween()
	var inactive_tween = create_tween()
	
	active_tween.tween_property(active_player, 'volume_linear', 0.0, TRANSITION_TIME)
	inactive_tween.tween_property(inactive_player, 'volume_linear', 1.0, TRANSITION_TIME)
	
	await active_tween.finished
	
	active_player.stop()
	active_player = inactive_player
	
	if active_player == PLAYER_1:
		inactive_player = PLAYER_2
	else:
		inactive_player = PLAYER_1
