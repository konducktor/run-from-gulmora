extends Control

@export var gameplay_scene: PackedScene

func _on_start_pressed():
	get_tree().change_scene_to_packed(gameplay_scene)


func _on_quit_pressed():
	get_tree().quit()


func _on_gmtk_logo_pressed():
	OS.shell_open("https://itch.io/jam/gmtk-2025")
