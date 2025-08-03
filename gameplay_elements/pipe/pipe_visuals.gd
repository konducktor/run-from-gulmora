extends Node2D


@export var PIPE_ENTER_TEXTURE : Texture2D
@export var PIPE_EXIT_TEXTURE : Texture2D

@export var SPRITE : Sprite2D
@export var PIPE : Node2D


func _ready() -> void:
	if PIPE.OTHER_PIPE:
		SPRITE.texture = PIPE_ENTER_TEXTURE
	else:
		SPRITE.texture = PIPE_EXIT_TEXTURE
