extends Node2D

@export var TRANSITION_TIME : float

@export var MAIN_SPRITES : Array[Sprite2D]
@export var TRANSITION_SPRITES : Array[Sprite2D]

@export var LAYER_ASSETS : Array[Texture2D]


func _ready() -> void:
	for transition_sprite in TRANSITION_SPRITES:
		transition_sprite.visible = false
	
	GlobalSignals.new_layer_reached.connect(_on_new_layer_reached)


func _on_new_layer_reached(layer: int) -> void:
	switch_layer(layer)


func switch_layer(asset_idx: int) -> void:
	for idx in range(len(MAIN_SPRITES)):
		tween_transition(MAIN_SPRITES[idx], TRANSITION_SPRITES[idx], LAYER_ASSETS[asset_idx])


func tween_transition(main_sprite: Sprite2D, transition_sprite: Sprite2D, new_asset: Texture2D) -> void:
	transition_sprite.texture = new_asset
	transition_sprite.modulate = Color.TRANSPARENT
	transition_sprite.visible = true
	
	var main_tween = create_tween()
	var transition_tween = create_tween()
	
	main_tween.tween_property(main_sprite, 'modulate', Color.TRANSPARENT, TRANSITION_TIME)
	transition_tween.tween_property(transition_sprite, 'modulate', Color.WHITE, TRANSITION_TIME)
	
	await main_tween.finished
	
	main_sprite.texture = new_asset
	main_sprite.modulate = Color.WHITE
	transition_sprite.visible = false
