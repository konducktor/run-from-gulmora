extends Control


@export var MUSIC_SLIDER : HSlider
@export var SFX_SLIDER : HSlider


func _ready() -> void:
	MUSIC_SLIDER.value = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("Music"))
	SFX_SLIDER.value = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("SFX"))


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))


func _on_fullscreen_toggle_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
