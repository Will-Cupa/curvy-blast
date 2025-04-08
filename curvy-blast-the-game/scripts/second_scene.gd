extends Control

const WORLD_TUTO = preload("res://scenes/tuto/world-tuto.tscn")
var world = preload("res://scenes/GameLevel/LevelManager/world_select.tscn");
var settings = load("res://scenes/GameLevel/Menu/SettingsMenu.tscn")


func _on_quit_pressed():
	get_tree().quit();


func _on_play_pressed():
	get_tree().change_scene_to_packed(world);


func _on_tuto_pressed():
	get_tree().change_scene_to_packed(WORLD_TUTO);


func _on_settings_pressed():
	get_tree().change_scene_to_packed(settings);
