extends Control

#Video settings
@onready var display_option = $SettingTabs/Video/MarginContainer/VideoSettings/DisplayOption

#Audio settings
@onready var master_vol_slider = $SettingTabs/Audio/MarginContainer/AudioSettings/MasterVolSlider
@onready var music_vol_slider = $SettingTabs/Audio/MarginContainer/AudioSettings/MusicVolSlider

#Gameplay settings


var menuPrincipal = load("res://scenes/GameLevel/Two/second_scene.tscn");

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_display_option_item_selected(index):
	var isFull : bool = index == 1
	Global.toogle_fullscreen(isFull)


func _on_master_vol_slider_value_changed(value):
	Global.update_volume(0, value)


func _on_music_vol_slider_value_changed(value):
	Global.update_volume(1, value)


func _on_retour_pressed():
	get_tree().change_scene_to_packed(menuPrincipal)
