extends Node2D

@export var CANVAS : CanvasLayer
@export var GAME_VALUES : GameValues

@export var DEATH_SCREEN_TIMER : Timer
@export var DEATH_SCREEN : PackedScene

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	GlobalSignals.player_died.connect(_on_player_death)

func _on_player_death() -> void:
	DEATH_SCREEN_TIMER.start()
	await DEATH_SCREEN_TIMER.timeout
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	var death_screen_node : DeathScreen = DEATH_SCREEN.instantiate()
	death_screen_node.setup(GAME_VALUES.meters, GAME_VALUES.time)
	CANVAS.add_child(death_screen_node)
