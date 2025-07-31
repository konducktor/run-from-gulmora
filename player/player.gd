extends CharacterBody2D


@export var PLAYER_SPEED : float

@export var MAX_JUMPS : int

@export var JUMP_HEIGHT : float
@export var JUMP_PEAK_TIME : float
@export var JUMP_FALL_TIME : float


@onready var jump_velocity : float = ((2.0 * JUMP_HEIGHT) / JUMP_PEAK_TIME) * -1.0
@onready var jump_gravity : float = ((-2.0 * JUMP_HEIGHT) / (JUMP_PEAK_TIME ** 2)) * -1.0
@onready var fall_gravity : float = ((-2.0 * JUMP_HEIGHT) / (JUMP_FALL_TIME ** 2)) * -1.0

@onready var jump_amount : int

func _physics_process(delta: float) -> void:
	if is_on_floor():
		jump_amount = MAX_JUMPS
	else:
		velocity.y = calculate_gravity(delta, velocity.y)
	
	velocity.x = calculate_horizontal_movement(delta, velocity.x)
	velocity.y = calculate_jump(delta, velocity.y)
	
	move_and_slide()


func calculate_gravity(delta: float, vertical_velocity: float) -> float:
		if vertical_velocity < 0.0:
			return vertical_velocity + (jump_gravity * delta)
		
		return vertical_velocity + (fall_gravity * delta)


func calculate_jump(_delta: float, vertical_velocity: float) -> float:
	if (jump_amount > 0) or (jump_amount == -1):
		
		if Input.is_action_just_pressed('movement_jump'):
			if (jump_amount > 0):
				jump_amount -= 1
			
			return jump_velocity
	
	if velocity.y < 0.0:
		if Input.is_action_just_released("movement_jump"):
			return vertical_velocity * 0.5
	
	return vertical_velocity


func calculate_horizontal_movement(_delta: float, horizontal_velocity: float) -> float:
	var direction := Input.get_axis("movement_left", "movement_right")
	
	if direction:
		return direction * PLAYER_SPEED
	else:
		return move_toward(velocity.x, 0, PLAYER_SPEED)
