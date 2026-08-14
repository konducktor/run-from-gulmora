extends Area2D
class_name DashBubble

@export var SPEED : float

var direction : Vector2

var is_player_inside : bool :
	set(value):
		is_player_inside = value
		print("is_player_inside = ", is_player_inside)
var direction_locked : bool

var player : Player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group('Player')
	call_deferred("reparent", get_parent().get_parent().get_parent())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if is_player_inside:
		player.global_position = global_position
		
		if $JumpInsideCooldown.is_stopped():
			if not direction_locked:
				var dir_y = -int(Input.is_action_pressed("movement_jump"))
				var dir_x = Input.get_axis("movement_left", "movement_right")
				
				if dir_x or dir_y:
					direction = Vector2(dir_x, dir_y)
					print("direction picked! (%v)" % direction)
					await get_tree().create_timer(0.3)
					direction_locked = true
			else:
				if Input.is_action_just_pressed("movement_jump"):
					queue_free()
	
	if Input.is_key_label_pressed(KEY_Q):
		direction_locked = false
	
	if direction:
		global_position += direction * SPEED * delta

func _on_body_entered(body):
	if body is Player:
		is_player_inside = true
		player.disable_moving = true
		modulate.a = 0.5
		$JumpInsideCooldown.start()
	elif body is TileMapLayer:
		queue_free()


func _on_body_exited(body):
	if body is Player:
		is_player_inside = false
		player.disable_moving = false
		modulate.a = 1


func _on_area_entered(area):
	if area is Danger:
		GlobalSignals.player_died.emit()
	
	if area is DashBubble and direction:
		is_player_inside = false
		player.global_position = area.global_position
		queue_free()
