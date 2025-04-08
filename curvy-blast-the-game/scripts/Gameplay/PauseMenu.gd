extends Control


func _on_continue_pressed():
	visible = false
	get_tree().paused = false	


func _on_reset_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	


func _on_return_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/GameLevel/LevelManager/world_select.tscn")
	
