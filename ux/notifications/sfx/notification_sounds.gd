extends GameSounds
class_name NotificationSounds

@export var NOTIFICATION : AudioStreamPlayer 
@export var MONSTER : AudioStreamPlayer

func _on_notification_notified() -> void:
	play_sound(NOTIFICATION)

func monster() -> void:
	play_sound(MONSTER)
