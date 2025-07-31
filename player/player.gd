extends CharacterBody2D
class_name Player


signal jumped
signal falling
signal grounded


@export var PLAYER_SPEED : float

@export var EXTRA_JUMPS : int

@export var JUMP_HEIGHT : float
@export var JUMP_PEAK_TIME : float
@export var JUMP_FALL_TIME : float


@onready var jump_velocity : float = ((2.0 * JUMP_HEIGHT) / JUMP_PEAK_TIME) * -1.0
@onready var jump_gravity : float = ((-2.0 * JUMP_HEIGHT) / (JUMP_PEAK_TIME ** 2)) * -1.0
@onready var fall_gravity : float = ((-2.0 * JUMP_HEIGHT) / (JUMP_FALL_TIME ** 2)) * -1.0

var jump_amount : int
var has_died : bool

var previously_jumping : bool
var previously_falling : bool

@export var METERS_OFFSET: float
var meters:
	set(value):
		meters = clamp((-value + METERS_OFFSET) * 0.001, 0, INF)
		var clamped_value = clamp((-value + METERS_OFFSET) * 0.001, 0, INF)
		#meters = -value + METERS_OFFSET
		meters = snapped(clamped_value, 0.01)
		GlobalSignals.meters_updated.emit(meters)

func _ready():
	has_died = false
	GlobalSignals.player_died.connect(_on_death)


func _physics_process(delta: float) -> void:
	if is_on_floor():
		if previously_falling:
			previously_falling = false
			grounded.emit()
		
		jump_amount = EXTRA_JUMPS
	else:
		velocity.y = calculate_gravity(delta, velocity.y)
	
	velocity.x = calculate_horizontal_movement(delta, velocity.x)
	velocity.y = calculate_jump(delta, velocity.y)
	
	meters = position.y
	
	move_and_slide()


func calculate_gravity(delta: float, vertical_velocity: float) -> float:
		if vertical_velocity < 0.0:
			previously_jumping = true
			return vertical_velocity + (jump_gravity * delta)
		
		if previously_jumping:
			previously_jumping = false
			previously_falling = true
			
			falling.emit()
		
		return vertical_velocity + (fall_gravity * delta)


func calculate_jump(_delta: float, vertical_velocity: float) -> float:
	var is_grounded := is_on_floor()
	if is_grounded or (jump_amount > 0) or (EXTRA_JUMPS == -1):
		if Input.is_action_just_pressed('movement_jump'):
			if not is_grounded:
				jump_amount -= 1
			
			jumped.emit()
			return jump_velocity
	
	if velocity.y < 0.0:
		if Input.is_action_just_released("movement_jump"):
			return vertical_velocity * 0.5
	
	return vertical_velocity


func calculate_horizontal_movement(_delta: float, _horizontal_velocity: float) -> float:
	var direction := Input.get_axis("movement_left", "movement_right")
	
	if direction:
		return direction * PLAYER_SPEED
	else:
		return move_toward(velocity.x, 0, PLAYER_SPEED)


func _on_death():
	has_died = true
