extends GhostState
class_name GhostStateActive


@export var IDLE_STATE : GhostState
var player_caught : bool

var current_target : Vector2
var current_direction : Vector2

var velocity : Vector2

func enter() -> void:
	super()
	player_caught = false
	update_current_target()


func update(delta: float) -> GhostState:
	velocity = current_direction * ghost.SPEED * delta
	
	ghost.position += velocity
	
	if (current_target - ghost.position).length() < 3.0:
		update_current_target()
	
	if (ghost.get_local(player.position) - ghost.start_position).length() > ghost.PASSIVE_RANGE:
		return IDLE_STATE
	return null


func update_current_target():
	current_target = ghost.get_local(player.position)
	current_direction = (current_target - ghost.position).normalized()
