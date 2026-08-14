extends Area2D
class_name PLayerJetpack


signal activated
signal deactivated


@export var vertical_speed: float
@export var acceleration: float

@export var horizontal_speed: float

@export_group("References")
@export var player: Player

var active: bool
var velocity: Vector2

var _timer: Timer
var _can_exit: bool


func _ready() -> void:
	_timer = %JetpackTimer
	GlobalSignals.jetpack_picked_up.connect(_on_jetpack_picked_up)


func _on_jetpack_picked_up() -> void:
	_timer.start()
	_can_exit = false
	
	global_position = player.global_position
	velocity.y = player.velocity.y


func _on_timer_timeout() -> void:
	_can_exit = true


func _physics_process(delta: float) -> void:
	if GlobalValues.current_player_type != GlobalValues.PlayerType.JETPACK:
		visible = false
		return
	else:
		visible = true
	
	if _can_exit and not has_overlapping_bodies():
		exit_jetpack()
	
	var direction := Input.get_axis("movement_left", "movement_right")
	if direction:
		velocity.x = direction * horizontal_speed
	else:
		velocity.x = move_toward(velocity.x, 0, horizontal_speed)
	
	
	if velocity.y > -vertical_speed:
		velocity.y -= acceleration
	
	if velocity.y < -vertical_speed:
		velocity.y = -vertical_speed
	
	position += velocity * delta


func exit_jetpack() -> void:
	player.global_position = global_position
	player.velocity.y = velocity.y
	
	GlobalSignals.jetpack_finished.emit()
