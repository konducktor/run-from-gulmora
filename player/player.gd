extends CharacterBody2D


@export var PLAYER_SPEED : float

@export var JUMP_HEIGHT : float
@export var JUMP_PEAK_TIME : float
@export var JUMP_FALL_TIME : float


@onready var jump_velocity : float = ((2.0 * JUMP_HEIGHT) / JUMP_PEAK_TIME) * -1.0
@onready var jump_gravity : float = ((-2.0 * JUMP_HEIGHT) / (JUMP_PEAK_TIME ** 2)) * -1.0
@onready var fall_gravity : float = ((-2.0 * JUMP_HEIGHT) / (JUMP_FALL_TIME ** 2)) * -1.0


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y = calculate_gravity(delta, velocity.y)
	
	velocity.x = calculate_horizontal_movement(delta, velocity.x)
	velocity.y = calculate_jump(delta, velocity.y)
	
	move_and_slide()


func calculate_gravity(delta: float, vertical_velocity: float) -> float:
		if vertical_velocity < 0.0:
			return vertical_velocity + (jump_gravity * delta)
		
		return vertical_velocity + (fall_gravity * delta)


func calculate_jump(delta: float, vertical_velocity: float) -> float:
	if is_on_floor():
		if Input.is_action_just_pressed('movement_jump'):
			return jump_velocity
	
	if velocity.y < 0.0:
		if Input.is_action_just_released("movement_jump"):
			return vertical_velocity * 0.5
	
	return vertical_velocity


func calculate_horizontal_movement(delta: float, horizontal_velocity: float) -> float:
	var direction := Input.get_axis("movement_left", "movement_right")
	
	if direction:
		return direction * PLAYER_SPEED
	else:
		return move_toward(velocity.x, 0, PLAYER_SPEED)
