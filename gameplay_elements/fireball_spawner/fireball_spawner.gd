extends Node2D


@export var COOLDOWN : float = 1.0
@export var FIREBALL_SPEED : float = 700.0
@export var FIREBALL_DIRECTION : Fireball.DIRECTIONS
@export var FIREBALL_TRAVEL_DISTANCE : float = 2048.0

@export_group("References")
@export var PROTOTYPE : PackedScene

var time : float


func _ready() -> void:
	spawn_fireball() 
	time = 0


func _physics_process(delta: float) -> void:
	time += delta
	
	if time >= COOLDOWN:
		time = 0
		spawn_fireball()


func spawn_fireball():
	var fireball : Fireball = PROTOTYPE.instantiate()
	
	fireball.DIRECTION = FIREBALL_DIRECTION
	fireball.SPEED = FIREBALL_SPEED
	fireball.TRAVEL_DISTANCE = FIREBALL_TRAVEL_DISTANCE
	
	add_child(fireball)
