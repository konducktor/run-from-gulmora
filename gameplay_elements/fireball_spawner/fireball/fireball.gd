extends Node2D
class_name Fireball

@export var SPEED : float = 700

enum DIRECTIONS {RIGHT=0, LEFT=1, UP=2, DOWN=3}
@export var DIRECTION : DIRECTIONS = DIRECTIONS.RIGHT
@export var TRAVEL_DISTANCE : float = 2048.0

var velocity : Vector2
var direction : Vector2
var traveled : float

func _ready() -> void:
	traveled = 0.0
	
	match DIRECTION:
		DIRECTIONS.RIGHT:
			direction = Vector2.RIGHT
		DIRECTIONS.LEFT:
			direction = Vector2.LEFT
		DIRECTIONS.UP:
			direction = Vector2.UP
		DIRECTIONS.DOWN:
			direction = Vector2.DOWN

func _physics_process(delta: float) -> void:
	velocity = direction * SPEED * delta
	
	position += velocity
	traveled += velocity.length()
	
	if traveled >= TRAVEL_DISTANCE:
		queue_free()
