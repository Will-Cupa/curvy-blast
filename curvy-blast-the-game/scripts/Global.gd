extends Node

signal brightness_updated(value)

var current_level : PackedScene
var collectables_by_level : Dictionary = {
}

func toogle_fullscreen(value):
	if value:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func update_volume(bus_indx, vol):
	AudioServer.set_bus_volume_db(bus_indx, vol)
