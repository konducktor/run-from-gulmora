extends Node2D


@export var enabled : bool = true

@export var REFERENCE_OBJECT : Node2D
@export var OFFSET : float

func _ready() -> void:
	GlobalSignals.player_died.connect(_on_player_death)


func _process(_delta: float) -> void:
	if not enabled:
		return
	
	position = Vector2(position.x, REFERENCE_OBJECT.position.y - OFFSET)


func _on_player_death():
	enabled = false
