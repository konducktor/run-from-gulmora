extends Area2D
class_name Letter


@export var letter_textures : Array[Texture2D]

@export_group("References")
@export var collison_shape : CollisionShape2D
@export var sprite : Sprite2D


func _ready() -> void:
	set_letter()
	GlobalSignals.letter_collected.connect(_on_letter_collected)

func _on_letter_collected():
	set_letter()


func set_letter() -> void:
	sprite.texture = letter_textures[GlobalValues.letter_count % 4]


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	
	collison_shape.set_deferred('disabled', true)
	sprite.visible = false
	
	GlobalSignals.letter_collected.emit()
