extends Node


@export var ANIMATED_SPRITE : AnimatedSprite2D
@export var PLAYER : Player

enum ANIMATED_STATES {GROUNDED, JUMPING, FALLING, DEAD}
var animation_state

func _ready() -> void:
	animation_state = ANIMATED_STATES.GROUNDED
	ANIMATED_SPRITE.play('idle_1')
	
	GlobalSignals.player_died.connect(_on_player_death)

func _process(_delta: float) -> void:
	var player_velocity : Vector2 = PLAYER.velocity
	
	if animation_state == ANIMATED_STATES.GROUNDED:
		if player_velocity.x == 0:
			ANIMATED_SPRITE.play('idle_1')
		else:
			ANIMATED_SPRITE.play('walking')
	
	ANIMATED_SPRITE.flip_h = (player_velocity.x < 0.0)


func _on_player_grounded() -> void:
	animation_state = ANIMATED_STATES.GROUNDED

func _on_player_jumped() -> void:
	animation_state = ANIMATED_STATES.JUMPING
	ANIMATED_SPRITE.play('jump')

func _on_player_falling() -> void:
	animation_state = ANIMATED_STATES.FALLING
	ANIMATED_SPRITE.play('fall')

func _on_player_death():
	animation_state = ANIMATED_STATES.DEAD
	ANIMATED_SPRITE.play('dead')
