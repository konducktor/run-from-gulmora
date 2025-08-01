extends Node2D


@export var NORMAL_SPEED : float
@export var SLOW_SPEED : float

@export var FAST_SPEED : float
@export var FAST_MIN_DISTANCE : float
#@export var FAST_SPEED_STOP_DISTANCE : float

@export var PLAYER : Player


enum SPEED_STATES {
	NORMAL = 0, SLOW = 1, FAST = 2, BACK = 3
}

var current_speed_state : SPEED_STATES
var current_speed : float

var vertical_velocity : float


func _ready() -> void:
	
	current_speed_state = SPEED_STATES.NORMAL
	current_speed = NORMAL_SPEED
	
	GlobalSignals.monster_normal.connect(_on_normal)
	GlobalSignals.monster_slowed.connect(_on_slowed)
	
	GlobalSignals.final_level_reached.connect(_on_final_level_reached)
	GlobalSignals.player_died.connect(_on_player_death)


func _physics_process(delta: float) -> void:
	vertical_velocity = current_speed * delta * (-1.0)
	position.y += vertical_velocity
	
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


func _on_normal() -> void:
	new_speed_state(SPEED_STATES.NORMAL)

func _on_slowed() -> void:
	new_speed_state(SPEED_STATES.SLOW)

func _on_final_level_reached() -> void:
	new_speed_state(SPEED_STATES.BACK)

func _on_player_death() -> void:
	new_speed_state(SPEED_STATES.BACK)
