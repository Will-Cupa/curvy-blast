
extends Control
class_name LevelSelect

var current_level : LevelIcon

var move_tween : Tween
var world_select = load("res://scenes/LevelSelection/LevelManager/world_select.tscn")

@onready var level_list = [
	$LevelIcon1,
	$LevelIcon2,
	$LevelIcon3
]

# Called when the node enters the scene tree for the first time.
func _ready():
	print(Global.current_level_id)
	if Global.current_level_id == null:
		current_level = level_list[0]
	else:
		current_level = level_list[Global.current_level_id]
		print(current_level)

	$PlayerIcon.global_position = current_level.global_position



#Called when the player press direction button
func _input(event):
	if move_tween and move_tween.is_running():
		return 
	if event.is_action_pressed("ui_left") and current_level.next_level_left:
		current_level = current_level.next_level_left
		tween_icon()
	elif event.is_action_pressed("ui_right") and current_level.next_level_right:
		current_level = current_level.next_level_right
		tween_icon()
	elif event.is_action_pressed("ui_up") and current_level.next_level_up:
		current_level = current_level.next_level_up
		tween_icon()
	elif event.is_action_pressed("ui_down") and current_level.next_level_down:
		current_level = current_level.next_level_down
		tween_icon()
	
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_packed(world_select)
	
	if event.is_action_pressed("ui_accept"):
		if current_level.next_scene_path:
			Global.current_level = current_level.next_scene_path
			Global.current_level_id = level_list.find(current_level)
			print(Global.current_level_id)
			get_tree().change_scene_to_packed(current_level.next_scene_path)

func tween_icon():
	$PlayerIcon/body.play("walk");
	$PlayerIcon/outline.play("walk")
	
	move_tween = get_tree().create_tween()
	move_tween.tween_property($PlayerIcon, "global_position", current_level.global_position, 1.5).set_trans(Tween.TRANS_SINE)
	
	move_tween.connect("finished", Callable(self, "_on_tween_finished"))

func _on_tween_finished():
	$PlayerIcon/body.play("idle");
	$PlayerIcon/outline.play("idle")
