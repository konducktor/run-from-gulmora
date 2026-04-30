extends Control


@export var GAME_VALUES : GameValues

@export var METERS_LABEL : Label
@export var TIME_LABEL : Label
@export var CURRENT_ROOM_LABEL : Label

@export var LEFT_LABEL : Label
@export var RIGHT_LABEL : Label
@export var JUMP_LABEL : Label


func _ready() -> void:
	GlobalSignals.next_level_path.connect(_on_next_level)

func _process(_delta: float) -> void:
	METERS_LABEL.text = 'Height: ' + str(GAME_VALUES.meters) + 'm'
	
	@warning_ignore("integer_division")
	TIME_LABEL.text = 'Time: ' + str(GAME_VALUES.time/60) + ':' + str(GAME_VALUES.time % 60)  + 's'


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("movement_right"):
		RIGHT_LABEL.text = "right"
	if Input.is_action_just_pressed("movement_left"):
		LEFT_LABEL.text = "left"
	if Input.is_action_just_pressed("movement_jump"):
		JUMP_LABEL.text = "jump"
	
	if Input.is_action_just_released("movement_jump"):
		JUMP_LABEL.text = ""
	if Input.is_action_just_released("movement_left"):
		LEFT_LABEL.text = ""
	if Input.is_action_just_released("movement_right"):
		RIGHT_LABEL.text = ""


func _on_next_level(path: String):
	CURRENT_ROOM_LABEL.text = "Room: " + path
