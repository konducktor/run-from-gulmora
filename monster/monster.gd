extends Node2D


@export var NORMAL_SPEED : float
@export var SLOW_SPEED : float

@export var ACCELERATION : float
@export var MAX_SPEED : float

enum SPEED_STATES {NORMAL, SLOW, BACK}

var current_speed_state : SPEED_STATES
var current_speed : float

var vertical_velocity : float

func _ready() -> void:
	current_speed_state = SPEED_STATES.NORMAL
	current_speed = NORMAL_SPEED
	
	GlobalSignals.monster_normal.connect(_on_normal)
	GlobalSignals.monster_slowed.connect(_on_slowed)
	
	GlobalSignals.final_level_reached.connect(_on_final_level_reached)


func _physics_process(delta: float) -> void:
	vertical_velocity = current_speed * delta * (-1.0)
	position.y += vertical_velocity
	
	if (current_speed_state == SPEED_STATES.NORMAL) and (current_speed < MAX_SPEED):
		current_speed += ACCELERATION * delta
		
		if current_speed >= MAX_SPEED:
			current_speed = MAX_SPEED


func _on_normal() -> void:
	current_speed_state = SPEED_STATES.NORMAL
	current_speed = NORMAL_SPEED

func _on_slowed() -> void:
	current_speed_state = SPEED_STATES.SLOW
	current_speed = SLOW_SPEED


func _on_final_level_reached() -> void:
	current_speed_state = SPEED_STATES.BACK
	current_speed = -NORMAL_SPEED
