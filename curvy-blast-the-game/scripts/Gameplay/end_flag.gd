extends AnimatableBody2D

@onready var win_timer: Timer = $winTimer
@onready var sprite = $Sprite2D
#@export var nextScenePath : String

var worldScenes = [
	"res://scenes/LevelSelection/LevelManager/level_select_world.tscn",
	"res://scenes/LevelSelection/LevelManager/level_select_world_2.tscn",
	"res://scenes/LevelSelection/LevelManager/level_select_world_3.tscn",
	"res://scenes/Menu/MainMenu.tscn"
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !win_timer.is_stopped():
		sprite.scale = sprite.scale.lerp(Vector2(0,0),0.1)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		win_timer.start()
		print("you win")



func _on_win_timer_timeout() -> void:
	sprite.hide()
	var total_collectable = get_parent().total_colletable
	Global.collectables_by_level[Global.current_level] = total_collectable
	DialogManager.clean()
	get_tree().change_scene_to_file(worldScenes[Global.current_world_id])
