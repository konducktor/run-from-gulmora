extends Node
class_name GhostState

signal entered
signal exited

var player : Player
var ghost : Ghost

var self_state_current : bool

func enter() -> void:
	entered.emit()
	self_state_current = true

func exit() -> void:
	exited.emit()
	self_state_current = false

func update(_delta: float) -> GhostState:
	return null
