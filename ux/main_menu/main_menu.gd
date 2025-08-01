extends Control

@export var gameplay_scene: PackedScene

func _on_start_pressed():
	get_tree().change_scene_to_packed(gameplay_scene)


func _on_settings_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()



func _on_music_slider_value_changed(value):
	print(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))


func _on_sfx_slider_value_changed(value):
	print(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))


func _on_fullscreen_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_gmtk_logo_pressed():
	OS.shell_open("https://itch.io/jam/gmtk-2025")
