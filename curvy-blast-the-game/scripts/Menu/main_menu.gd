extends Control

const WORLD_TUTO = preload("res://scenes/tuto/world-tuto.tscn")
const world = preload("res://scenes/LevelSelection/LevelManager/world_select.tscn")
const settings = preload("res://scenes/Menu/SettingsMenu.tscn")


func _on_quit_pressed():
	get_tree().quit();


func _on_play_pressed():
	Global.current_world_id = 0
	get_tree().change_scene_to_packed(world);


func _on_tuto_pressed():
	Global.current_world_id = 3 #main menu, needed to redirect player to this menu at the end of the tutorial
	get_tree().change_scene_to_packed(WORLD_TUTO);


func _on_settings_pressed():
	get_tree().change_scene_to_packed(settings);
