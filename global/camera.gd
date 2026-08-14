extends Node2D


@export var enabled : bool = true

@export var REFERENCE_OBJECT : Node
@export var OFFSET : float

func _ready() -> void:
	GlobalSignals.player_died.connect(_on_player_death)


func _process(_delta: float) -> void:
	if not enabled:
		return
	
	for child in REFERENCE_OBJECT.get_children():
		var node := child as Node2D
		
		if node.visible:
			position = Vector2(position.x, node.position.y - OFFSET)
			break


func _on_player_death():
	enabled = false
