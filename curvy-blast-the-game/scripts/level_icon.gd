@tool
extends Control
class_name LevelIcon

@export var level_name : String = "1"
@export var next_scene_path: PackedScene
@export var next_level_up : LevelIcon
@export var next_level_down : LevelIcon
@export var next_level_right : LevelIcon
@export var next_level_left : LevelIcon
@export var collectable : Array[TextureRect]
@onready var h_box_container = $HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = "Level  " + level_name
	for child in h_box_container.get_children():
		collectable.append(child)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Engine.is_editor_hint():
		$Label.text = "Level  " + level_name
