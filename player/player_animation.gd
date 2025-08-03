extends Node


@export var PLAYER_DEATH_IMPACT_VELOCITY : Vector2

@export_group("References")
@export var ANIMATED_SPRITE : AnimatedSprite2D
@export var COLLISION : CollisionShape2D
@export var PLAYER : Player

enum ANIMATED_STATES {GROUNDED, JUMPING, FALLING, DEAD, HYPED}
var animation_state


func _ready() -> void:
	animation_state = ANIMATED_STATES.GROUNDED
	ANIMATED_SPRITE.play('idle_1')
	
	GlobalSignals.player_died.connect(_on_player_death)


func _process(_delta: float) -> void:
	var player_velocity : Vector2 = PLAYER.velocity
	ANIMATED_SPRITE.flip_h = (player_velocity.x < 0.0)


func _on_player_idle() -> void:
	if animation_state in [ANIMATED_STATES.DEAD, ANIMATED_STATES.HYPED]:
		return
	
	ANIMATED_SPRITE.play('idle_1')


func _on_player_walking() -> void:
	if animation_state == ANIMATED_STATES.DEAD:
		return
	
	animation_state = ANIMATED_STATES.GROUNDED
	ANIMATED_SPRITE.play('walking')


func _on_player_jumped() -> void:
	if animation_state in [ANIMATED_STATES.DEAD, ANIMATED_STATES.HYPED]:
		return
	
	animation_state = ANIMATED_STATES.JUMPING
	ANIMATED_SPRITE.play('jump')


func _on_player_falling() -> void:
	if animation_state in [ANIMATED_STATES.DEAD, ANIMATED_STATES.HYPED]:
		return
	
	animation_state = ANIMATED_STATES.FALLING
	ANIMATED_SPRITE.play('fall')


func _on_player_death() -> void:
	animation_state = ANIMATED_STATES.DEAD
	ANIMATED_SPRITE.play('dead')
	
	PLAYER.velocity = PLAYER_DEATH_IMPACT_VELOCITY
	COLLISION.set_deferred('disabled', true)


func _on_player_hyped() -> void:
	if animation_state == ANIMATED_STATES.DEAD:
		return
	
	animation_state = ANIMATED_STATES.HYPED
	ANIMATED_SPRITE.play('hyped')
