extends Node
class_name GameSounds


var random : RandomNumberGenerator


func _ready() -> void:
	random = RandomNumberGenerator.new()


func play_sound(stream_player: AudioStreamPlayer, pitch: float = 1.0) -> void:
	if (stream_player == null):
		return
	
	if (!stream_player.playing) or (stream_player.max_polyphony > 1):
		#stream_player.volume_db = Global.sound_volume
		stream_player.set_pitch_scale(pitch)
		stream_player.play()


func stop_sound(stream_player: AudioStreamPlayer) -> void:
	if (stream_player == null) or (!stream_player.playing):
		return
	
	await stream_player.finished
	stream_player.stop()


func random_pitch(min_value: float = 0.9, max_value: float = 1.1):
	return random.randf_range(min_value, max_value)
