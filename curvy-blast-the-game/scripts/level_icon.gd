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
	if Global.collectables_by_level.has(next_scene_path):
		niveau_1_score = Global.collectables_by_level.get(next_scene_path, 0)
		for child in range(niveau_1_score):
			print(h_box_container.get_child(child).visible)
			h_box_container.get_child(child).visible = true
	$Label.text = "Level  " + level_name
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Engine.is_editor_hint():
		$Label.text = "Level  " + level_name
