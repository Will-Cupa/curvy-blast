extends Control

#Video settings
@onready var display_option = $SettingTabs/Video/MarginContainer/VideoSettings/DisplayOption

#Audio settings
@onready var master_vol_slider = $SettingTabs/Audio/MarginContainer/AudioSettings/MasterVolSlider
@onready var music_vol_slider = $SettingTabs/Audio/MarginContainer/AudioSettings/MusicVolSlider

#Gameplay settings
@onready var game_settings = $SettingTabs/Gameplay/MarginContainer/VideoSettings
@onready var input_button : PackedScene = preload("res://scenes/input_button.tscn")
@onready var timerScene = preload("res://scenes/Gameplay/speedrun_timer.tscn")

var input_actions = {
	"ui_left" : "Se deplacer a gauche",
	"ui_right": "Se deplacer a droite",
	"jump": "Sauter",
	"ui_accept": "Valider",
	"ui_cancel": "Retour",
	"pass_dialog": "Passer les dialogues",
}

var is_remapping = false
var action_to_remap = null
var remapping_button = null

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_on_create_grid_list()

func _on_display_option_item_selected(index):
	var isFull : bool = index == 1
	Global.toogle_fullscreen(isFull)


func _on_master_vol_slider_value_changed(value):
	Global.update_volume(0, value)


func _on_music_vol_slider_value_changed(value):
	Global.update_volume(1, value)


func _on_retour_pressed():
	get_tree().change_scene_to_file("res://scenes/Menu/MainMenu.tscn")

func _on_create_grid_list():
	pass
	#InputMap.load_from_project_settings()
	#for item in game_settings.get_children():
		#item.queue_free()
	#
	#for action in input_actions:
		#var button = input_button.instantiate()
		#if button is Button:
			#var action_label = button.find_child("LabelAction")
			#var key_label = button.find_child("LabelKey")
			#
			#action_label.text = input_actions[action]
			#var events = InputMap.action_get_events(action)
			#if events.size() > 0:
				#key_label.text = events[0].as_text().trim_suffix(" (Physical)")
			#else:
				#key_label.text = ""
			#
			#game_settings.get_node('GameSettings').add_child(button)
			#button.mouse_filter = Control.MOUSE_FILTER_PASS
			#if button.is_pressed():
				#print("salut")
			#button.connect("pressed", _on_input_button_pressed.bind(button, action))
#
#func _on_input_button_pressed(button , action):
	#print("salut")
	#if !is_remapping:
		#is_remapping = true
		#action_to_remap = action
		#remapping_button = button
		#button.find_child("LabelKey").text = "Appuie sur une touche..."

func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Global.timer = timerScene.instantiate()
		get_tree().get_root().add_child(Global.timer)
	else:
		Global.timer.queue_free()
			
