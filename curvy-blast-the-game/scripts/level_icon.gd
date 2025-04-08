@tool
extends Control
class_name LevelIcon

@export var level_name : String = "1"
var niveau_1_score : int
@export var next_scene_path: PackedScene
@export var next_level_up : LevelIcon
@export var next_level_down : LevelIcon
@export var next_level_right : LevelIcon
@export var next_level_left : LevelIcon
@export var collectable : Array[TextureRect]
@onready var h_box_container = $HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.collectables_by_level:
		niveau_1_score = Global.collectables_by_level.get(next_scene_path, 0)
	$Label.text = "Level  " + level_name
	if niveau_1_score:
		for child in range(niveau_1_score):
			h_box_container.get_child(child).visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Engine.is_editor_hint():
		$Label.text = "Level  " + level_name
