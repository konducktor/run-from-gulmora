extends Node2D
class_name Ghost


@export var SPEED : float

@export var ANGER_RANGE : float
@export var PASSIVE_RANGE : float

@export_group("References")
@export var STATE_MACHINE : GhostStateMachine

var player : Player

var start_position : Vector2
var parent : Node2D


func _ready() -> void:
	player = get_tree().get_nodes_in_group("Player")[0]
	start_position = position
	parent = get_parent()
	
	STATE_MACHINE.init(player, self)


func get_local(pos: Vector2):
	return parent.to_local(pos)
