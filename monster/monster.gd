extends Node2D


@export var ACTIVE : bool = true

@export_group("Balancing")
@export var NORMAL_SPEED : float
@export var SLOW_SPEED : float

@export var FAST_SPEED : float
@export var FAST_MIN_DISTANCE : float

@export_group("References")
@export var PLAYER : Player


enum SPEED_STATES {
	NORMAL = 0, SLOW = 1, FAST = 2, BACK = 3, STOP = 4
}

var current_speed_state : SPEED_STATES
var current_speed : float


func _ready() -> void:
	if not ACTIVE:
		return
	
	if GlobalValues.is_tutorial_finished:
		new_speed_state(SPEED_STATES.NORMAL)
	else:
		new_speed_state(SPEED_STATES.STOP)
	
	GlobalSignals.monster_normal.connect(_on_normal)
	GlobalSignals.monster_slowed.connect(_on_slowed)
	GlobalSignals.final_level_reached.connect(_on_final_level_reached)
	GlobalSignals.player_died.connect(_on_player_death)
	GlobalSignals.tutorial_finished.connect(_on_tutorial_finished)
	GlobalSignals.new_lap_started.connect(_on_new_lap_started)


func _physics_process(delta: float) -> void:
	if not ACTIVE:
		return
	
	position.y += current_speed * delta * (-1.0)
	
	var distance_to_player := absf(PLAYER.position.y - position.y)
	
	if current_speed_state in [SPEED_STATES.NORMAL, SPEED_STATES.FAST]:
		if distance_to_player > FAST_MIN_DISTANCE:
			new_speed_state(SPEED_STATES.FAST)
		else:
			new_speed_state(SPEED_STATES.NORMAL)


func new_speed_state(new_state: SPEED_STATES):
	current_speed_state = new_state
	
	match new_state:
		SPEED_STATES.NORMAL:
			current_speed = NORMAL_SPEED
		SPEED_STATES.SLOW:
			current_speed = SLOW_SPEED
		SPEED_STATES.FAST:
			current_speed = FAST_SPEED
		SPEED_STATES.BACK:
			current_speed = -NORMAL_SPEED
		SPEED_STATES.STOP:
			current_speed = 0.0


func _on_tutorial_finished():
	#position.y = PLAYER.position.y + 640.0 # Расстояние по дефолту
	new_speed_state(SPEED_STATES.NORMAL)

func _on_normal() -> void:
	new_speed_state(SPEED_STATES.NORMAL)

func _on_slowed() -> void:
	new_speed_state(SPEED_STATES.SLOW)

func _on_final_level_reached() -> void:
	new_speed_state(SPEED_STATES.BACK)

func _on_player_death() -> void:
	new_speed_state(SPEED_STATES.BACK)

func _on_new_lap_started() -> void:
	NORMAL_SPEED += 50.0
	new_speed_state(SPEED_STATES.NORMAL)
