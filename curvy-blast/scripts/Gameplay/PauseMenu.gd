extends Control

var worldScenes = [
	"res://scenes/LevelSelection/LevelManager/level_select_world.tscn",
	"res://scenes/LevelSelection/LevelManager/level_select_world_2.tscn",
	"res://scenes/LevelSelection/LevelManager/level_select_world_3.tscn",
	"res://scenes/Menu/MainMenu.tscn"
]

func _on_continue_pressed():
	visible = false
	get_tree().paused = false	


func _on_reset_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	


func _on_return_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file(worldScenes[Global.current_world_id])
	
