extends Button

@export var hover_scale: Vector2 = Vector2(1.1, 1.1)
@export var pressed_scale: Vector2 = Vector2(0.9, 0.9)

@export var hover_tween_time: float = 0.1
@export var press_tween_time: float = 0.06
@export var trans_type: Tween.TransitionType = Tween.TRANS_SINE

# Called when the node enters the scene tree for the first time.
func _ready():
	mouse_entered.connect(_button_enter)
	mouse_exited.connect(_button_exit)
	pressed.connect(_button_pressed)
	
	call_deferred("_init_pivot")

#func _process(_delta):
	#create_tween().tween_property(self, "scale", Vector2(1.05, 1.05), 2).set_trans(trans_type)
	#create_tween().tween_property(self, "scale", Vector2(0.95, 0.95), 2).set_trans(trans_type)

func _init_pivot():
	pivot_offset = size/2.0

func _button_enter():
	create_tween().tween_property(self, "scale", hover_scale, hover_tween_time).set_trans(trans_type)

func _button_exit():
	create_tween().tween_property(self, "scale", Vector2.ONE, hover_tween_time).set_trans(trans_type)

func _button_pressed():
	var button_press_tween: Tween = create_tween()
	button_press_tween.tween_property(self, "scale", pressed_scale, press_tween_time).set_trans(trans_type)
	button_press_tween.tween_property(self, "scale", hover_scale, hover_tween_time).set_trans(trans_type)
