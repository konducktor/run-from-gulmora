extends CharacterBody2D
class_name Player


signal jumped
signal falling
signal fall
signal idle
signal walking

@export_group('Balancing')
@export var PLAYER_SPEED : float

@export var EXTRA_JUMPS : int
@export var MAX_VERTICAL_SPEED : float

@export var JUMP_HEIGHT : float
@export var JUMP_PEAK_TIME : float
@export var JUMP_FALL_TIME : float

@export_group('References')
@export var COYOTE_TIMER : Timer


@onready var jump_velocity : float = ((2.0 * JUMP_HEIGHT) / JUMP_PEAK_TIME) * -1.0
@onready var jump_gravity : float = ((-2.0 * JUMP_HEIGHT) / (JUMP_PEAK_TIME ** 2)) * -1.0
@onready var fall_gravity : float = ((-2.0 * JUMP_HEIGHT) / (JUMP_FALL_TIME ** 2)) * -1.0

var jump_amount : int
var has_died : bool

var can_release : bool

var previously_jumping : bool
var previously_falling : bool
var previously_walking : bool
var previously_grounded : bool

func _ready():
	can_release = true
	has_died = false
	previously_walking = false
	GlobalSignals.player_died.connect(_on_death)


func _physics_process(delta: float) -> void:
	if is_on_floor():
		if previously_falling:
			previously_falling = false
			fall.emit()
			
			if velocity.x == 0:
				idle.emit()
			else:
				walking.emit()
		
		previously_grounded = true
		jump_amount = EXTRA_JUMPS
		
		if (velocity.x == 0) and previously_walking:
			previously_walking = false
			idle.emit()
		
		if (velocity.x != 0) and ((not previously_walking) or is_on_wall()):
			previously_walking = true
			walking.emit()
	else:
		velocity.y = calculate_gravity(delta, velocity.y)
	
	if not has_died:
		velocity.x = calculate_horizontal_movement(delta, velocity.x)
		velocity.y = calculate_jump(delta, velocity.y)
	
	velocity.y = clampf(velocity.y, -12000.0, 12000.0)
	
	move_and_slide()


func calculate_gravity(delta: float, vertical_velocity: float) -> float:
	if vertical_velocity < 0.0:
		previously_jumping = true
		return vertical_velocity + (jump_gravity * delta)
	
	if vertical_velocity > 0.0:
		if previously_jumping:
			previously_jumping = false
		
		if not previously_falling:
			previously_falling = true
			
			if previously_grounded:
				COYOTE_TIMER.start()
			
			falling.emit()
	
	return vertical_velocity + (fall_gravity * delta)


func calculate_jump(_delta: float, vertical_velocity: float) -> float:
	var is_grounded : bool = (is_on_floor() or (not COYOTE_TIMER.is_stopped()))
	
	if is_grounded or (jump_amount > 0) or (EXTRA_JUMPS == -1):
		if Input.is_action_just_pressed('movement_jump'):
			if not is_grounded:
				jump_amount -= 1
			
			previously_grounded = false
			COYOTE_TIMER.stop()
			
			jumped.emit()
			return jump_velocity
	
	if velocity.y < 0.0:
		if Input.is_action_just_released("movement_jump") and can_release:
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

func reset_extra_jumps():
	jump_amount = EXTRA_JUMPS

func disable_release(duration=0.1):
	can_release = false
	await get_tree().create_timer(duration, true, false, true).timeout
	can_release = true
