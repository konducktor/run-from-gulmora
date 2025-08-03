extends Control

@export var gameplay_scene: PackedScene
@export var settings_panel: Panel
@export var main_panel: Control
@export var button_anim_timer: Timer

func _on_start_pressed():
	button_anim_timer.start()
	await button_anim_timer.timeout
	
	get_tree().change_scene_to_packed(gameplay_scene)

func _on_quit_pressed():
	button_anim_timer.start()
	await button_anim_timer.timeout
	
	get_tree().quit()


func _on_gmtk_logo_pressed():
	button_anim_timer.start()
	await button_anim_timer.timeout
	
	OS.shell_open("https://itch.io/jam/gmtk-2025")


func _on_settings_pressed():
	button_anim_timer.start()
	await button_anim_timer.timeout
	
	settings_panel.visible = true
	main_panel.visible = false


func _on_settings_back_pressed():
	button_anim_timer.start()
	await button_anim_timer.timeout
	
	settings_panel.visible = false
	main_panel.visible = true
