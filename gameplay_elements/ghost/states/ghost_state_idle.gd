extends GhostState
class_name GhostStateIdle


@export var ACTIVE_STATE : GhostState

var ignore_range : bool


func enter():
	super()
	
	ignore_range = (player.position - ghost.start_position).length() < ghost.ANGER_RANGE


func update(delta: float) -> GhostState:
	if (ghost.position - ghost.start_position).length() > 3.0:
		var velocity = (ghost.start_position - ghost.position).normalized() * ghost.SPEED * delta
		ghost.position += velocity
	else:
		ignore_range = false
	
	if ignore_range:
		return
	
	if (player.position - ghost.start_position).length() < ghost.ANGER_RANGE:
		return ACTIVE_STATE
	return null
	
