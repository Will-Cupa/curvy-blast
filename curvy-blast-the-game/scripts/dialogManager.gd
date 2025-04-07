extends Node

@onready var text_box_scene : PackedScene = preload('res://scenes/GameLevel/textBox.tscn')

var dialog_lines
var current_line_index = 0

var text_box
var text_box_position : Vector2

var is_dialog_active = false
var can_advance_line = false

var acualPanneau

func start_dialog(position: Vector2, lines, panneau):
	if acualPanneau == panneau:
		return
	
	current_line_index = 0
	acualPanneau = panneau
	dialog_lines = lines
	text_box_position = position
	_show_text_box()
	is_dialog_active = true

func _show_text_box():
	text_box = text_box_scene.instantiate()
	text_box.finished_displaying.connect(_on_text_box_finished_displaying)
	get_tree().root.add_child(text_box)
	text_box.global_position = text_box_position
	text_box.display_text(dialog_lines[current_line_index])
	can_advance_line = false

func _on_text_box_finished_displaying():
	can_advance_line = true
	
func nextLine():
	text_box.queue_free()
	current_line_index += 1
	if current_line_index >= dialog_lines.size():
		is_dialog_active = false
		current_line_index = 0
		return
	_show_text_box()

func _unhandled_input(event):
	if event.is_action_pressed("pass_dialog") && is_dialog_active && can_advance_line:
		text_box.queue_free()
		current_line_index += 1
		if current_line_index >= dialog_lines.size():
			is_dialog_active = false
			current_line_index = 0
			return
		_show_text_box()
	pass
