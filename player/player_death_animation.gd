extends Node2D


@export var player_death_impact_velocity : Vector2

@export_group("References")
@export var collision_shape : CollisionShape2D
@export var player : Player


func _ready() -> void:
	GlobalSignals.player_died.connect(_on_player_death)


func _on_player_death():
	player.velocity = player_death_impact_velocity
	collision_shape.set_deferred('disabled', true)
