extends Node2D

@export var LINK: String

@export var AUDIO_PLAYER : AudioStreamPlayer
@export var ANIMATION_PLAYER : AnimationPlayer

@export var MAIN_MENU : PackedScene

func _ready() -> void:
	AUDIO_PLAYER.play()
	ANIMATION_PLAYER.play("credits")
	
	await ANIMATION_PLAYER.animation_finished
	
	OS.shell_open(LINK)


func _on_menu_pressed() -> void:
	get_tree().call_deferred('change_scene_to_packed', MAIN_MENU)
