extends Node2D


@export var SPRITES : Array[Sprite2D]
@export var LAYER_ASSETS : Array[Texture2D]


func _ready() -> void:
	GlobalSignals.new_layer_reached.connect(_on_new_layer_reached)


func _on_new_layer_reached(layer: int) -> void:
	switch_layer(layer)


func switch_layer(asset_idx: int) -> void:
	for sprite in SPRITES:
		sprite.texture = LAYER_ASSETS[asset_idx]
