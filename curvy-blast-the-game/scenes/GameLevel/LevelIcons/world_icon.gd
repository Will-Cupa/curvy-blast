@tool
extends Control

@export var level_index : int = 1
@export var level_select_packed : PackedScene = load("res://scenes/LevelManager/level_select_test.tscn")
@onready var level_select_scene : LevelSelect = level_select_packed.instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = "World  " + str(level_index)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Engine.is_editor_hint():
		$Label.text = "World  " + str(level_index)
