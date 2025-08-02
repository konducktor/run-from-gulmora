extends Node2D
class_name Ghost


@export var SPEED : float

@export var ANGER_RANGE : float
@export var PASSIVE_RANGE : float

@export_group("References")
@export var STATE_MACHINE : GhostStateMachine

var player : Player
var start_position : Vector2


func _ready() -> void:
	player = get_tree().get_nodes_in_group("Player")[0]
	start_position = position
	
	STATE_MACHINE.init(player, self)
