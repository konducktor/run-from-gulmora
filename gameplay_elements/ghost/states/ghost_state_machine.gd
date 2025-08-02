extends Node
class_name GhostStateMachine


@export var INITIAL_STATE : GhostState

var current_state : GhostState


func init(player: Player, ghost : Ghost) -> void:
	for child in get_children():
		child.player = player
		child.ghost = ghost
	
	change_current_state(INITIAL_STATE)

func _physics_process(delta: float) -> void:
	var new_state = current_state.update(delta)
	if new_state:
		change_current_state(new_state)


func change_current_state(new_state: GhostState) -> void:
	if current_state:
		current_state.exit()
		
	new_state.enter()
	current_state = new_state
