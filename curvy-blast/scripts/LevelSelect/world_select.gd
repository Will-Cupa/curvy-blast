extends Control

@onready var worlds : Array = [$WorldIcon1, $WorldIcon2, $WorldIcon3]
var current_world : int
var move_tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.current_world_id == null:
		current_world = 0
	else:
		current_world = Global.current_world_id
	$PlayerIcon.global_position = worlds[current_world].global_position


#Called when the player press direction button
func _input(event):
	if move_tween and move_tween.is_running():
		return 
	if event.is_action_pressed("ui_left") and current_world > 0:
		current_world -= 1
		tween_icon()
	elif event.is_action_pressed("ui_right") and current_world < worlds.size() - 1:
		current_world += 1
		tween_icon()
	
	if event.is_action_pressed("ui_accept"):
		if worlds[current_world].level_select_scene:
			Global.current_world_id = current_world
			get_tree().get_root().add_child(worlds[current_world].level_select_scene)
			get_tree().current_scene = worlds[current_world].level_select_scene
			get_tree().get_root().remove_child(self)
	
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://scenes/Menu/MainMenu.tscn")

func tween_icon():
	$PlayerIcon/body.play("walk");
	$PlayerIcon/outline.play("walk")
	
	move_tween = get_tree().create_tween()
	move_tween.tween_property($PlayerIcon, "global_position", worlds[current_world].global_position, 1.0).set_trans(Tween.TRANS_SINE)
	move_tween.connect("finished", Callable(self, "_on_tween_finished"))

func _on_tween_finished():
	$PlayerIcon/body.play("idle");
	$PlayerIcon/outline.play("idle")
