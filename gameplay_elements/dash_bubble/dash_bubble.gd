extends Area2D

var direction : Vector2

var is_player_inside : bool :
	set(value):
		is_player_inside = value
		print("is_player_inside = ", is_player_inside)

var player : Player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group('Player')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body is Player:
		is_player_inside = true
		player.disable_moving = true
		player.global_position = global_position
		modulate.a = 0.5


func _on_body_exited(body):
	if body is Player:
		is_player_inside = false
